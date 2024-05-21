import 'package:flutter/material.dart';
import 'package:learn/ui/screens/gallery/download_provider.dart';
import 'package:provider/provider.dart';

class DownloadProgressDialog extends StatefulWidget {
  const DownloadProgressDialog({super.key, required this.url});
  final String url;

  @override
  State<DownloadProgressDialog> createState() => _DownloadProgressDialogState();
}

class _DownloadProgressDialogState extends State<DownloadProgressDialog> {

  @override
  void initState() {
    super.initState();
    Provider.of<DownloadProvider>(context, listen: false).startDownload(widget.url);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Consumer<DownloadProvider>(
        builder: (_, downloadProvider, __) {
          if (downloadProvider.progress == 1.0) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.of(context).pop();
            });
          }

          if (downloadProvider.errorMessage != null) {
            return Text(downloadProvider.errorMessage!);
          }

          String downloadingProgress = (downloadProvider.progress * 100).toInt().toString();

          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: const Text(
                  'Downloading',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
              LinearProgressIndicator(
                value: downloadProvider.progress,
                backgroundColor: Colors.grey,
                borderRadius: BorderRadius.circular(5.0),
                color: Colors.green,
                minHeight: 10,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Text('$downloadingProgress %'),
              ),
            ],
          );
        },
      ),
    );
  }
}
