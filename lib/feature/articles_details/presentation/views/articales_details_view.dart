import 'package:digital_hub_task/feature/home/data/model/Articles.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticleDetailScreen extends StatelessWidget {
  final Articles article;

  const ArticleDetailScreen({super.key, required this.article});

  // فنكشن بتفتح اللينك في المتصفح
  Future<void> _openUrl(BuildContext context, String? url) async {
    if (url == null || url.isEmpty) {
      // لو مفيش لينك، هيطبع رسالة خطأ
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("URL مش موجود")));
      return;
    }

    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      // لو معرفش يفتح اللينك
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("مش قادر يفتح $url")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(article.title ?? "Article"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // لو في صورة للأرتيكل اعرضها
            if (article.urlToImage != null && article.urlToImage!.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  article.urlToImage!,
                  fit: BoxFit.cover,
                  errorBuilder:(context, error, stackTrace) => const Icon(
                    Icons.broken_image,
                    size: 100,
                    color: Colors.grey,
                  ),
                ),
              )
            else
            // لو مفيش صورة اعرض صندوق رمادي
              Container(
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Icon(
                    Icons.image_not_supported,
                    size: 80,
                    color: Colors.grey,
                  ),
                ),
              ),

            const SizedBox(height: 20),

            // عنوان الخبر
            Text(
              article.title ?? "مفيش عنوان",
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12),

            // وصف الخبر
            Text(
              article.description ?? "مفيش وصف",
              style: const TextStyle(fontSize: 16, color: Colors.black87),
            ),

            const SizedBox(height: 24),

            // زرار يفتح المقال كامل في المتصفح
            Center(
              child: ElevatedButton.icon(
                onPressed: () => _openUrl(context, article.url),
                icon: const Icon(Icons.open_in_browser, size: 20),
                label: const Text(
                  "افتح المقال كامل",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 28,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  elevation: 4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
