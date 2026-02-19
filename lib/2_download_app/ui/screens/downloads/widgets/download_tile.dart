import 'package:flutter/material.dart';
import 'package:mobile_dev_w4/2_download_app/ui/theme/theme.dart';

import 'download_controller.dart';

class DownloadTile extends StatelessWidget {
  const DownloadTile({super.key, required this.controller});

  final DownloadController controller;


  IconData get iconData => switch (controller.status) {
    == DownloadStatus.notDownloaded => Icons.download,
    == DownloadStatus.downloading => Icons.downloading,
    == DownloadStatus.downloading => Icons.folder,
    _ => Icons.abc,
  };

  @override
  Widget build(BuildContext context) {

    return Card(
      clipBehavior: Clip.hardEdge,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListenableBuilder(
          listenable: controller,
          builder: (context, child) {
            return ListTile(
              // tileColor: Colors.amber,
              title: Text(controller.ressource.name, style: AppTextStyles.label),
              subtitle: Text(
                "${controller.progress.toStringAsFixed(1)} % completed - ${(controller.progress / 100 * controller.ressource.size).toStringAsFixed(1)} of ${controller.ressource.size} MB"
                ,
                style: AppTextStyles.label
                    .copyWith(color: AppColors.neutral)
                    .copyWith(fontWeight: FontWeight.w600),
              ),
              trailing: IconButton(onPressed:controller.startDownload, icon: Icon(iconData)),
            );
          }
        ),
      ),
    );

    // TODO
  }
}
