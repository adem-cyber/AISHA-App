import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/repository/store_repo_vendor.dart';

import 'package:flutter_application_1/pages/vendor/home/store_model_vendor.dart';

import 'package:flutter_application_1/utils/colors.dart';
import 'package:flutter_application_1/utils/dimensions.dart';
import 'package:flutter_application_1/widgets/big_text.dart';
import 'package:flutter_application_1/widgets/icon_and_text.dart';
import 'package:flutter_application_1/widgets/small_text.dart';
import 'package:get/get.dart';

import 'grocery_store_list.dart';

class GroceryShopBody extends StatefulWidget {
  const GroceryShopBody({Key? key, required this.Store}) : super(key: key);

  final String Store;
  @override
  State<GroceryShopBody> createState() => _GroceryShopBodyState();
}

class _GroceryShopBodyState extends State<GroceryShopBody> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(StoreRepoVendor());

    return SingleChildScrollView(
        child: Column(
      children: [
        //FOOD STORE text
        SizedBox(
          height: Dimensions.height10,
        ),
        Container(
          margin: EdgeInsets.only(left: Dimensions.width30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText(text: widget.Store),
              SizedBox(
                width: Dimensions.width10,
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 3),
                child: BigText(
                  text: ".",
                  color: Colors.black26,
                ),
              ),
              SizedBox(
                width: Dimensions.width10,
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 2),
                child: SamllText(text: "Popular"),
              ),
            ],
          ),
        ),

        //list of food and images
        FutureBuilder<List<StoreModelVendor>>(
            future: controller.getStoreType(widget.Store),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Get.to(
                            () => const GroceryStoreList(),
                            arguments: {
                              'name': snapshot.data![index].name,
                              'description': snapshot.data![index].description,
                              'location': snapshot.data![index].location,
                              'storeid': snapshot.data![index].storeid,
                              'email': snapshot.data![index].email,
                              'phone': snapshot.data![index].phone,
                              'image': snapshot.data![index].image,
                              'vendorid': snapshot.data![index].vendorid,
                              'type': snapshot.data![index].type,
                            },
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                              left: Dimensions.width20,
                              right: Dimensions.width20,
                              bottom: Dimensions.height10),
                          child: Row(
                            children: [
                              Container(
                                width: Dimensions.ListViewImgSize / 1.2,
                                height: Dimensions.ListViewImgSize / 1.3,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(Dimensions.width10),
                                  color: Colors.amber[300],
                                ),
                                child: Image.network(
                                  snapshot.data![index].image,
                                  fit: BoxFit.cover,
                                ),
                              ),

                              //text container
                              Expanded(
                                child: Container(
                                  height: Dimensions.ListViewTextsize / 1.2,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(
                                          Dimensions.radius30 / 1.5),
                                      bottomRight: Radius.circular(
                                          Dimensions.radius30 / 1.5),
                                    ),
                                    color: const Color.fromARGB(
                                        255, 220, 240, 240),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: Dimensions.width10,
                                        right: Dimensions.width10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        BigText(
                                          text: snapshot.data![index].name,
                                          size: 17,
                                        ),
                                        SizedBox(
                                          height: Dimensions.height20,
                                        ),
                                        Row(
                                          children: [
                                            Wrap(
                                              children: List.generate(
                                                  5,
                                                  (index) => const Icon(
                                                        Icons.star,
                                                        color: AppColors
                                                            .yellowcolor,
                                                        size: 10,
                                                      )),
                                            ),
                                            SizedBox(
                                              width: Dimensions.height20,
                                            ),
                                            SamllText(text: "4.5"),
                                            SizedBox(
                                              width: Dimensions.height10,
                                            ),
                                            SamllText(text: '1287'),
                                            SizedBox(
                                              width: Dimensions.height10,
                                            ),
                                            SamllText(text: "comments"),
                                          ],
                                        ),
                                        SizedBox(
                                          height: Dimensions.height10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            IconAndTextWidget(
                                                icon: Icons.location_on,
                                                text: snapshot
                                                    .data![index].location,
                                                iconColor: AppColors.mainColor),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                } else {
                  return const Center(child: Text("Something went wrong"));
                }
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ],
    ));
  }
}
