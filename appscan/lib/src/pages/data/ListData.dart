import 'package:appscan/src/bloc/list/product_bloc.dart';
import 'package:appscan/src/utils/UtilsColot.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListData extends StatefulWidget {
  const ListData({super.key});

  @override
  State<StatefulWidget> createState() => _StateBody();
}

class _StateBody extends State<ListData> {
  // ignore: prefer_typing_uninitialized_variables
  ProductBloc? bloc;
  @override
  void initState() {
    bloc = BlocProvider.of<ProductBloc>(context);
    bloc!.add(ProductFind());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          child: BlocBuilder<ProductBloc, ProductState>(
            bloc: bloc,
            builder: (context, state) {
              if (state is ProductInitial) {
                return Text("Chargement encours...");
              }
              if (state is ProductLoading) {
                return Text("Chargement encours...");
              }
              if (state is ProductLoaded) {
                // print(state.data[0].nomComplet);
                return Padding(
                  padding: const EdgeInsets.only(bottom: 50.0),
                  child: ListView.separated(
                    separatorBuilder: (context, state) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        height: 3,
                        color: color_blue,
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
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Material(
                                        borderRadius: BorderRadius.circular(20),
                                        color: color_blue,
                                        child: SizedBox(
                                            height: 40,
                                            width: 40,
                                            child: Center(
                                                child: Text(
                                              state.data[index].id.toString(),
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold, fontSize: 16),
                                            ))),
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(state.data[index].dateSortie
                                            .toString()
                                            .substring(0, 10),
                                            style: TextStyle(
                                              fontWeight: FontWeight.normal,
                                              color: Colors.grey
                                            ),
                                            ),
                                        Text(state.data[index].typesortie),
                                        Text(
                                            state.data[index].client.nomComplet,
                                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                            )
                                      ],
                                    )
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
        )
      ],
    );
  }
}
