// ignore_for_file: sort_child_properties_last, prefer_const_constructors

import 'dart:developer';
import 'dart:io';
import 'package:appscan/src/bloc/list/product_bloc.dart';
import 'package:appscan/src/bloc/scan/scan_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../controller/Controller.dart';

class Scan extends StatefulWidget {
  const Scan({super.key});
  @override
  State<StatefulWidget> createState() => _Body();
}

class _Body extends State<Scan> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Controller contrller = Get.put(Controller());

  Barcode? result;
  QRViewController? controller;
  ScanBloc? bloc;
  bool isProgress = false;
  ProductBloc? blocProduct;
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  void initState() {
    bloc = BlocProvider.of<ScanBloc>(context);
    blocProduct = BlocProvider.of<ProductBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size;
    return SizedBox(
      child: ModalProgressHUD(
        inAsyncCall: isProgress,
        progressIndicator: SpinKitPouringHourGlass(
          color: Colors.red,
          size: 70,
        ),
        child: Stack(
          children: <Widget>[
            Container(
              width: w.width,
              height: w.height,
              color: Colors.white,
              child: Column(
                children: [
                  BlocListener<ScanBloc, ScanState>(
                    listener: (context, state) {
                      if (state is ScanInitial) {
                        setState(() {
                          isProgress = true;
                            contrller.isloadings(true);
                        });
                      }
                      if (state is ScanLoading) {
                        setState(() {
                          isProgress = true;
                            contrller.isloadings(true);
                        });
                      }
                      if (state is ScanInvalid) {
                        setState(() {
                          isProgress = false; 
                          Get.back();
                          contrller.isloadings(false);                     
                        });
                      }
                      if (state is ScanSucces) {
                        setState(() {
                          isProgress = false;
                          blocProduct!.add(ProductFind());
                          Get.back();
                        });
                      }
                    },
                    child: BlocBuilder<ScanBloc, ScanState>(
                      builder: (context, state) {
                        return Expanded(flex: 4, child: _buildQrView(context));
                      },
                    ),
                  ),
                  // if(result!=null)

                  // Expanded(
                  //   flex: 1,
                  //   child: Center(
                  //     child:

                  //      (result != null)
                  //         ? Text(
                  //             'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}')
                  //         : Text('Scan a code'),
                  //   ),
                  // ),
                ],
              ),
            ),
            Positioned(
              bottom: 100,
              width: w.width,
              child: Center(
                child: TextButton(
                    child: Text("Close".toUpperCase(),
                        style: TextStyle(fontSize: 14)),
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            EdgeInsets.all(15)),
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.red),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: BorderSide(color: Colors.red)))),
                    onPressed: () => Get.back()),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        bloc!.add(ScanSend(id: result!.code.toString().trim()));
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
