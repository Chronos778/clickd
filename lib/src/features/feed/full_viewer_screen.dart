import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';
import 'package:gal/gal.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import '../../core/models/photo_model.dart';
import 'feed_provider.dart';

class FullViewerScreen extends ConsumerStatefulWidget {
  final String initialPhotoId;
  
  const FullViewerScreen({super.key, required this.initialPhotoId});

  @override
  ConsumerState<FullViewerScreen> createState() => _FullViewerScreenState();
}

class _FullViewerScreenState extends ConsumerState<FullViewerScreen> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    // We will initialize the controller in the build method once we find the index
  }

  Future<void> _downloadPhoto(PhotoModel photo) async {
    if (photo.fullUrl == null) return;
    
    try {
      final hasAccess = await Gal.hasAccess();
      if (!hasAccess) {
        await Gal.requestAccess();
      }

      // Download file to cache first
      final file = await DefaultCacheManager().getSingleFile(photo.fullUrl!);
      await Gal.putImage(file.path, album: 'Clickd');
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Saved to gallery!')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save: $e')),
        );
      }
    }
  }

  Future<void> _sharePhoto(PhotoModel photo) async {
    if (photo.fullUrl == null) return;

    try {
      final file = await DefaultCacheManager().getSingleFile(photo.fullUrl!);
      await Share.shareXFiles([XFile(file.path)], text: 'Check out this photo from Clickd!');
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to share: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final feedState = ref.watch(feedProvider);

    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: feedState.when(
        data: (photos) {
          final initialIndex = photos.indexWhere((p) => p.id == widget.initialPhotoId);
          _pageController = PageController(initialPage: initialIndex >= 0 ? initialIndex : 0);

          return PageView.builder(
            controller: _pageController,
            itemCount: photos.length,
            itemBuilder: (context, index) {
              final photo = photos[index];
              return Stack(
                fit: StackFit.expand,
                children: [
                  InteractiveViewer(
                    minScale: 1.0,
                    maxScale: 4.0,
                    child: photo.fullUrl != null || photo.thumbUrl != null
                        ? CachedNetworkImage(
                            imageUrl: (photo.fullUrl ?? photo.thumbUrl)!,
                            fit: BoxFit.contain,
                            placeholder: (context, url) => const Center(child: CircularProgressIndicator(color: Colors.white)),
                            errorWidget: (context, url, error) => const Icon(Icons.error, color: Colors.white),
                          )
                        : const Icon(Icons.broken_image, color: Colors.white, size: 50),
                  ),
                  
                  // Bottom Controls
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black.withOpacity(0.8),
                            Colors.transparent,
                          ],
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const CircleAvatar(
                                radius: 16,
                                backgroundColor: Colors.grey,
                                child: Icon(Icons.person, size: 16, color: Colors.white),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                photo.uploadedBy,
                                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.download, color: Colors.white),
                                onPressed: () => _downloadPhoto(photo),
                              ),
                              IconButton(
                                icon: const Icon(Icons.share, color: Colors.white),
                                onPressed: () => _sharePhoto(photo),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator(color: Colors.white)),
        error: (e, s) => Center(child: Text('Error: $e', style: const TextStyle(color: Colors.white))),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
