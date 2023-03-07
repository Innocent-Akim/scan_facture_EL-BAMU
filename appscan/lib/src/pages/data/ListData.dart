import 'package:animations/animations.dart';
import 'package:appscan/src/bloc/list/product_bloc.dart';
import 'package:appscan/src/utils/UtilsColot.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import '../../controller/Controller.dart';
import '../../utils/navbar.dart';
import '../../utils/pk_skeleton.dart';

class ListData extends StatefulWidget {
  const ListData({super.key});

  @override
  State<StatefulWidget> createState() => _StateBody();
}

class _StateBody extends State<ListData> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  ProductBloc? bloc;
    Controller contrller = Get.put(Controller());


  @override
  void initState() {
    print(contrller.isloadings);
    _controller = AnimationController(
      value: 0.0,
      duration: const Duration(milliseconds: 150),
      reverseDuration: const Duration(milliseconds: 75),
      vsync: this,
    )..addStatusListener((AnimationStatus status) {
        setState(() {});
      });
    bloc = BlocProvider.of<ProductBloc>(context);
    bloc!.add(ProductFind());
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> refresh() async {
    await Future.delayed(const Duration(seconds: 1)).whenComplete(() {
      setState(() {
        bloc!.add(ProductFind());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     floatingActionButton: FloatingActionButton(
      backgroundColor:AppFont.blueColor ,
    child: const Icon(Icons.qr_code_scanner_outlined, color: Colors.white),
    onPressed: () {
      setState(() {
        Get.toNamed('/scan');
      });
    },
  ),
   floatingActionButtonLocation:
      FloatingActionButtonLocation.miniCenterFloat,
      body: RefreshIndicator(
        triggerMode: RefreshIndicatorTriggerMode.anywhere,
        onRefresh: refresh,
        child: Stack(
          children: <Widget>[
            Positioned(
              child: BlocBuilder<ProductBloc, ProductState>(
                bloc: bloc,
                builder: (context, state) {
                  if (state is ProductInitial) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30.0),
                      child: Scaffold(
                        backgroundColor: Colors.white,
                        body: ListView.separated(
                          addRepaintBoundaries: false,
                          // controller: _controller.duration,
                          separatorBuilder: (context, state) {
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              height: 1,
                              color: const Color.fromARGB(61, 1, 89, 148)
                                  .withOpacity(.1),
                            );
                          },
                          itemCount: 10,
                          itemBuilder: (context, i) => PKCardSkeleton(),
                        ),
                      ),
                    );
                  }
                  if (state is ProductLoading) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30.0),
                      child: Scaffold(
                        backgroundColor: Colors.white,
                        body: ListView.separated(
                          separatorBuilder: (context, index) {
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              height: 2,
                              color: AppFont.blueColor.withOpacity(.1),
                            );
                          },
                          itemCount: 10,
                          itemBuilder: (context, i) => PKCardSkeleton(),
                        ),
                      ),
                    );
                  }
                  if (state is ProductEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Material(
                            child: SvgPicture.asset(
                              "assets/no data.svg",
                              width: 150,
                              height: 150,
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  if (state is ProductLoaded) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 0.0, top: 80),
                      child: ListView.separated(
                          scrollDirection: Axis.vertical,
                          separatorBuilder: (context, state) {
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              height: 2,
                              color: AppFont.blueColor.withOpacity(.1),
                            );
                          },
                          itemCount: state.data.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Material(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Material(
                                            elevation: 4,
                                            shadowColor: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: AppFont.blueColor,
                                            child: SizedBox(
                                                height: 40,
                                                width: 40,
                                                child: Center(
                                                    child: Text(
                                                  state.data[index].id
                                                      .toString(),
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ))),
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                state.data[index].dateSortie
                                                    .toString()
                                                    .substring(0, 10),
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: Colors.grey),
                                              ),
                                              Text(
                                                  state.data[index].typesortie),
                                              Text(
                                                state.data[index].client
                                                    .nomComplet,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16),
                                              )
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Material(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            elevation: 3,
                                            shadowColor: Colors.white,
                                            color: AppFont.blueColor
                                                .withOpacity(0.2),
                                            child: const SizedBox(
                                              height: 40,
                                              width: 40,
                                              child: Icon(
                                                  Icons.shopping_cart_outlined,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          }),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ),
            buildNavbar(
                icon: const Icon(LineIcons.barChart, color: AppFont.blueColor),
                size: MediaQuery.of(context).size,
                text: "Facture disponible"),
          ],
        ),
      ),
    );
  }
}
