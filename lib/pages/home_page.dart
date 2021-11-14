import 'dart:io';

import 'package:desktop_drop/desktop_drop.dart';
import 'package:flutter/material.dart';
import 'package:odin/painters/odin_logo_painter.dart';
import 'package:odin/painters/ripple_painter.dart';
import 'package:odin/services/data_service.dart';
import 'package:odin/services/file_picker_service.dart';
import 'package:odin/services/locator.dart';
import 'package:odin/services/zip_service.dart';
import 'package:odin/widgets/window_top_bar.dart';
import 'package:url_launcher/url_launcher.dart';

const backgroundStartColor = Color(0xFF7D5DEC);
const backgroundEndColor = Color(0xFF6148B9);

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;
  final Tween<double> _sizeTween = Tween(begin: .4, end: 1);

  bool _dragging = false;
  bool _loading = false;
  String? _fileLink;
  final _ds = locator<DataService>();
  final _zs = locator<ZipService>();
  final _fps = locator<FilepickerService>();
  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    animation = _sizeTween.animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeOut,
      ),
    )..addListener(() {
        setState(() {});
      });
    controller.repeat();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF7D5DEC),
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            colors: [backgroundStartColor, backgroundEndColor],
            radius: 2,
            center: Alignment.topLeft,
            stops: [0.0, 1.0],
          ),
        ),
        child: Stack(
          children: [
            CustomPaint(
              painter: RipplePainter(
                color: Colors.white,
                animationValue: animation.value,
              ),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: CustomPaint(
                size: Size(MediaQuery.of(context).size.width / 4.8,
                    (MediaQuery.of(context).size.width / 4.8 * 1).toDouble()),
                painter: OdinLogoCustomPainter(),
              ),
            ),
            DropTarget(
              onDragDone: (detail) async {
                setState(() {
                  _loading = true;
                });
                if (detail.urls.isNotEmpty) {
                  final int length = detail.urls.length;
                  if (length > 1) {
                    final List<File> fileToZips =
                        detail.urls.map((e) => File(e.toFilePath())).toList();
                    final zippedFile =
                        await _zs.zipFile(fileToZips: fileToZips);
                    _fileLink = await _ds.uploadFileAnonymous(zippedFile);
                  } else {
                    _fileLink = await _ds.uploadFileAnonymous(
                        File(detail.urls.first.toFilePath()));
                  }
                }
                setState(() {
                  _loading = false;
                });
              },
              onDragEntered: (detail) {
                setState(() {
                  _dragging = true;
                });
              },
              onDragExited: (detail) {
                setState(() {
                  _dragging = false;
                });
              },
              child: GestureDetector(
                onTap: _fileLink != null
                    ? () => launch(_fileLink ?? '')
                    : () async {
                        final linkFile = await _fps.getFiles();
                        setState(() {
                          _fileLink = linkFile;
                        });
                      },
                child: SizedBox.expand(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                    color: _dragging
                        ? Colors.blue.withOpacity(0.2)
                        : Colors.transparent,
                    child: Center(
                      child: _loading
                          ? CircularProgressIndicator(
                              backgroundColor: Colors.white.withOpacity(0.3),
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Spacer(flex: 9),
                                if (_fileLink != null)
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SelectableText(
                                      _fileLink.toString(),
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w100,
                                        color: Colors.white.withOpacity(0.6),
                                      ),
                                    ),
                                  ),
                                Text(
                                  "Files are saved  in an anonymous GitHub Repo, and will be deleted after 15 hours.",
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black.withOpacity(0.2)),
                                ),
                                const Spacer(flex: 1),
                              ],
                            ),
                    ),
                  ),
                ),
              ),
            ),
            const WindowTopBar(),
          ],
        ),
      ),
    );
  }
}
