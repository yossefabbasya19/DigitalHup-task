import 'package:digital_hub_task/core/app_color/app_color.dart';
import 'package:digital_hub_task/core/extention/get_defferent_datetime.dart';
import 'package:digital_hub_task/core/route_manager/my_router.dart';
import 'package:digital_hub_task/feature/home/data/model/Articles.dart';
import 'package:flutter/material.dart';

class NewsItemCard extends StatelessWidget {
  final Articles articles;

  const NewsItemCard({super.key, required this.articles});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        Navigator.pushNamed(
          context,
          MyRouter.articlesDetails,
          arguments: articles,
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: size.width * 0.03,
          vertical: size.height * 0.01,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColor.black.withOpacity(0.2), width: 1),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 6,
              offset: const Offset(0, 3),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: articles.urlToImage != null && articles.urlToImage!.isNotEmpty
                    ? Image.network(
                  articles.urlToImage!,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: Colors.grey.shade200,
                    child: const Icon(Icons.broken_image, size: 60, color: Colors.grey),
                  ),
                  loadingBuilder: (context, child, progress) {
                    if (progress == null) return child;
                    return  Center(child: CircularProgressIndicator(color: AppColor.black,));
                  },
                )
                    : Container(
                  color: Colors.grey.shade200,
                  child: const Icon(Icons.image, size: 60, color: Colors.grey),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    articles.title ?? 'No Title',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: AppColor.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          articles.author ?? "Unknown",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: AppColor.gary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Text(
                        articles.publishedAt?.differenceOnDateTime ?? "",
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: AppColor.gary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
