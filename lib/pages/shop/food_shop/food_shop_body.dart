import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/repository/store_repo.dart';
import 'package:flutter_application_1/model/store_model.dart';
import 'package:flutter_application_1/pages/shop/food_shop/food_store_list.dart';

import 'package:flutter_application_1/utils/colors.dart';
import 'package:flutter_application_1/utils/dimensions.dart';
import 'package:flutter_application_1/widgets/big_text.dart';
import 'package:flutter_application_1/widgets/icon_and_text.dart';
import 'package:flutter_application_1/widgets/small_text.dart';
import 'package:get/get.dart';


class FoodShopBody extends StatefulWidget {
  const FoodShopBody({super.key});

  @override
  State<FoodShopBody> createState() => _FoodShopBodyState();
}

class _FoodShopBodyState extends State<FoodShopBody> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(StoreRepo());
    

    return Column(
      children: [
        //FOOD STORE text
        SizedBox(
          height: Dimensions.height30,
        ),
        Container(
          margin: EdgeInsets.only(left: Dimensions.width30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText(text: "Restaurant"),
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
                child: SamllText(text: "Popular restaurant "),
              ),
            ],
          ),
        ),

        //list of food and images
        FutureBuilder<List<StoreModel>>(
            future: controller.getAllStore(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount:snapshot.data!.length ,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.only(
                            left: Dimensions.width20,
                            right: Dimensions.width20,
                            bottom: Dimensions.height10),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.to(() =>  const FoodStoreList());
                              },
                              child: Container(
                                width: Dimensions.ListViewImgSize,
                                height: Dimensions.ListViewImgSize,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(Dimensions.width20),
                                  color: Colors.amber[300],
                                ),
                                child: Image.network(
                                  snapshot.data![index].image,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            //text container
                            Expanded(
                              child: Container(
                                height: Dimensions.ListViewTextsize,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topRight:
                                        Radius.circular(Dimensions.radius30),
                                    bottomRight:
                                        Radius.circular(Dimensions.radius30),
                                  ),
                                  color: const Color.fromARGB(255, 220, 240, 240),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: Dimensions.width10,
                                      right: Dimensions.width10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      BigText(
                                        text: snapshot.data![index].name,
                                        size: 15,
                                      ),
                                      SizedBox(
                                        height: Dimensions.height10,
                                      ),
                                      SamllText(
                                          text: snapshot.data![index].location),
                                      SizedBox(
                                        height: Dimensions.height10,
                                      ),
                                      Row(
                                        children: [
                                          Wrap(
                                            children: List.generate(
                                                5,
                                                (index) => const Icon(
                                                      Icons.star,
                                                      color:
                                                          AppColors.mainColor,
                                                      size: 10,
                                                    )),
                                          ),
                                          SizedBox(
                                            width: Dimensions.height10,
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
                                      const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          IconAndTextWidget(
                                              icon: Icons.circle_sharp,
                                              text: "Normal",
                                              iconColor: AppColors.iconcolor1),
                                          IconAndTextWidget(
                                              icon: Icons.location_on,
                                              text: "1.5km",
                                              iconColor: AppColors.mainColor),
                                          IconAndTextWidget(
                                              icon: Icons.access_time_rounded,
                                              text: "Normal",
                                              iconColor: AppColors.iconcolor2),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
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
    );
  }
}
