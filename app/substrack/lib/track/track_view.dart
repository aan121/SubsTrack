import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:substrack/track/track_controller.dart';
import 'package:substrack/track/tracker_list/track_list_view.dart';
import 'package:substrack/util/color.dart';
import '../notification/notification_view.dart';
import '../signIn/login_view.dart';
import '../util/fonts_styles.dart';
import '../util/images.dart';

class Track extends StatelessWidget {
  const Track({super.key});

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(fontSize: 15, color: Colors.white);

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(
        '$value',
        style: style,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    TrackController controller = Get.put(TrackController());
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      await controller.fetchData();
    });
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: (){
                  Get.off(const Login());
                },
                child: Image.asset(Images.setting),
              ),
              const Text(
                "Substrack",
                style: FontStyles.Main_Home_Title,
              ),
              GestureDetector(
                onTap: () {
                  Get.to( NotificationView());
                },
                child: Image.asset(Images.notification),
              )
            ],
          ),
        ),
        backgroundColor: ThemeColors.background,
      ),
      body: Container(
        color: ThemeColors.background,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.white, width: 0.5),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Obx(() => BarChart(
                        BarChartData(
                          backgroundColor: ThemeColors.background,
                          barGroups: controller.barGroups,
                          borderData: FlBorderData(
                            border: const Border(
                              bottom: BorderSide(),
                              left: BorderSide(),
                            ),
                          ),
                          gridData: const FlGridData(show: false),
                          titlesData: FlTitlesData(
                            bottomTitles: AxisTitles(
                              sideTitles: _bottomTitles,
                            ),
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: (value, meta) {
                                  return Text(
                                    '\$$value',
                                    style: const TextStyle(
                                        fontSize: 5, color: Colors.white),
                                  );
                                },
                              ),
                            ),
                            topTitles: const AxisTitles(
                                sideTitles: SideTitles(showTitles: false)),
                            rightTitles: const AxisTitles(
                                sideTitles: SideTitles(showTitles: false)),
                          ),
                          barTouchData: BarTouchData(
                            touchTooltipData: BarTouchTooltipData(
                              tooltipBgColor: Colors.transparent,
                              tooltipPadding: const EdgeInsets.all(8),
                              tooltipMargin: 8,
                              getTooltipItem:
                                  (group, groupIndex, rod, rodIndex) {
                                print(rodIndex);
                                return BarTooltipItem(
                                  '\$${rod.toY.toInt()}',
                                  const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                );
                              },
                            ),
                          ),
                        ),
                      )),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        height: 200, // Adjust height as needed
                        child: Column(
                          children: [
                            Expanded(
                              child: ListView(
                                children: <Widget>[
                                  for (String category in [
                                    'All', 'Entertainment', 'Health and Fitness', 'News and Magazines', 'Food and Meal Services', 'Utilities', 'Transportation', 'Shopping and Retail', 'Productivity and Software', 'Education', 'Financial', 'Streaming Music', 'Streaming Video', 'Home and Lifestyle', 'Gaming', 'Travel and Hospitality', 'Personal Care', 'Other'
                                  ])
                                    ListTile(
                                      title: Text(category),
                                      onTap: () {
                                        controller
                                            .updateSelectedCategories(category);
                                        Navigator.pop(
                                            context); // Close the bottom sheet
                                      },
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                child: const Icon(
                  Icons.filter_list_alt,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: Obx(
                  () => Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: const GradientBoxBorder(
                            width: 1,
                            gradient: LinearGradient(colors: [
                              ThemeColors.tabColor,
                              Colors.indigo,
                            ]))),
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      physics: const ScrollPhysics(),
                      itemCount: controller.filterData.length,
                      // Disable scrolling
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TrackerList(
                            value: controller.filterData[index],
                            onTap: () {},
                            onChange: (value) {
                              controller.filterData[index] = value;
                            },
                            controller: controller,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  SideTitles get _bottomTitles => SideTitles(
        showTitles: true,
        getTitlesWidget: (value, meta) {
          String text = '';
          TrackController controller = Get.put(TrackController());
          int monthIndex = value.toInt() % 12;
          switch (monthIndex) {
            case 0:
              text = 'Jan';
              break;
            case 1:
              text = 'Feb';
              break;
            case 2:
              text = 'Mar';
              break;
            case 3:
              text = 'Apr';
              break;
            case 4:
              text = 'May';
              break;
            case 5:
              text = 'Jun';
              break;
            case 6:
              text = 'Jul';
              break;
            case 7:
              text = 'Aug';
              break;
            case 8:
              text = 'Sep';
              break;
            case 9:
              text = 'Oct';
              break;
            case 10:
              text = 'Nov';
              break;
            case 11:
              text = 'Dec';
              break;
          }
          return Text(
            text,
            style: TextStyle(fontSize: 10, color: Colors.white),
          );
        },
      );
}
