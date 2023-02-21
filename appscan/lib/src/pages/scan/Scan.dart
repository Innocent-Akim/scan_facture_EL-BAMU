import 'dart:developer';
import 'dart:io';

import 'package:appscan/src/utils/UtilsColot.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class Scan extends StatefulWidget {
  const Scan({super.key});

  @override
  State<StatefulWidget> createState() => _Body();
}

class _Body extends State<Scan> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size;
    return SizedBox(
      child: Stack(
        children: <Widget>[
          Container(
            width: w.width,
            height: w.height,
            color: Colors.white,
            child: Column(
              children: [
                Expanded(flex: 4, child: _buildQrView(context)),

                // Expanded(
                //   flex: 1,
                //   child: Center(
                //     child: (result != null)
                //         ? Text(
                //             'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}')
                //         : Text('Scan a code'),
                //   ),
                // )
              ],
            ),
          ),
          Positioned(
            bottom: 10,
            child: Container(
              width: 20,
              height: 20,
              // ignore: prefer_const_constructors
              decoration: BoxDecoration(color: Colors.yellow),
            ),
          )
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  Widget _buildQrView(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 20,
          borderLength: 40,
          borderWidth: 15,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
