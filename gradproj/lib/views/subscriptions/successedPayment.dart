import 'package:dio/dio.dart';
import "dart:html";
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gradproj/bloc/cubit.dart';
import 'package:gradproj/bloc/states.dart';
import 'package:gradproj/components/shared.dart';

class SuccessedPayment extends StatelessWidget {
  final String? url;
  const SuccessedPayment({super.key, this.url});

  @override
  Widget build(BuildContext context) {
    bool isUpgraded = false;
    bool isSuccess =
        Uri.parse(url!).queryParameters["success"] == "false" ? false : true;
    List<String> data =
        Uri.parse(url!).queryParameters["merchant_order_id"]!.split(",");
    return Scaffold(
        backgroundColor: themeData.primaryColor,
        body: BlocBuilder<SubscriptionCubit, States>(builder: (ctx, state) {
          return FutureBuilder(
              future: SubscriptionCubit.GET(context)
                  .successPayment(isSuccess, data[0], data[1]),
              builder: (context, AsyncSnapshot ss) {
                if (ss.hasData) {
                  if (ss.data != true && ss.data.statusCode == 200)
                    isUpgraded = true;
                  else
                    isUpgraded = false;

                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          isSuccess && isUpgraded
                              ? Icons.done_rounded
                              : Icons.close,
                          color: isSuccess && isUpgraded
                              ? Colors.green
                              : Colors.red,
                          size: 150,
                        ),
                        Text(
                          isSuccess && isUpgraded
                              ? "Payment Successed"
                              : "Payment Failed",
                          style: TextStyle(
                              fontSize: 45,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, "/home");
                            },
                            child: Text("Go Home"))
                      ],
                    ),
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              });
        }));
  }
}
