import 'package:flutter/material.dart';
import 'package:greengreen/src/colors.dart';
import 'package:greengreen/src/providers/plogging.pro.dart';
import 'package:greengreen/src/repository/location.rep.dart';
import 'package:greengreen/src/views/ing/component/circleButton.com.dart';
import 'package:greengreen/src/views/ing/component/ingMap.com.dart';
import 'package:greengreen/src/views/ing/component/status.com.dart';
import 'package:greengreen/src/views/ing/component/trashRow.com.dart';
import 'package:provider/provider.dart';

class IngView extends StatefulWidget {
  const IngView({Key? key}) : super(key: key);

  @override
  _IngViewState createState() => _IngViewState();
}

class _IngViewState extends State<IngView> {
  late PloggingProvider _ploggingProvider;

  @override
  void initState() {
    super.initState();
    _ploggingProvider = Provider.of<PloggingProvider>(context, listen: false);
    _ploggingProvider.initPlogging();
  }

  @override
  Widget build(BuildContext context) {
    double halfScreenHeight = MediaQuery.of(context).size.height / 2;
    double buttonRowHeight = 80;

    return Material(
      child: Stack(
        children: [
          Container(
            color: whiteColor,
            child: Column(
              children: [
                // Map
                Container(
                  height: halfScreenHeight,
                  child: Stack(
                    children: [
                      MapComponent(),
                      Consumer<PloggingProvider>(
                          builder: (context, provider, child) {
                        return Positioned(
                          top: 20 + MediaQuery.of(context).padding.top,
                          left: 20,
                          child: StatusComponent(
                            walkCount: provider.plogging.walkCount,
                            walkTime: Duration(
                              seconds: provider.plogging.walkTime,
                            ),
                          ),
                        );
                      }),
                      Positioned(
                        top: 20 + MediaQuery.of(context).padding.top,
                        left: MediaQuery.of(context).size.width - 60,
                        child: InkWell(
                          onTap: _ploggingProvider.resetMyLocation,
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(
                                color: const Color(0xff707070),
                                width: 1,
                              ),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x16000029),
                                  spreadRadius: 0,
                                  blurRadius: 6,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.my_location_rounded,
                              color: Color(0xffDB4437),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Buttons
                SizedBox(
                  height: halfScreenHeight,
                  child: Column(
                    children: [
                      // 쓰레기 버튼들
                      Container(
                        height: halfScreenHeight - buttonRowHeight - 1,
                        padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
                        child: Consumer<PloggingProvider>(
                            builder: (context, provider, child) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TrashRow(
                                trashtype: "플라스틱",
                                count: provider.plogging.plasticCount,
                                upMethod: () => provider.countTakeTrash(0, 1),
                                downMethod: () =>
                                    provider.countTakeTrash(0, -1),
                              ),
                              TrashRow(
                                trashtype: "종이",
                                count: provider.plogging.paperCount,
                                upMethod: () => provider.countTakeTrash(1, 1),
                                downMethod: () =>
                                    provider.countTakeTrash(1, -1),
                              ),
                              TrashRow(
                                trashtype: "일반쓰레기",
                                count: provider.plogging.wasteCount,
                                upMethod: () => provider.countTakeTrash(2, 1),
                                downMethod: () =>
                                    provider.countTakeTrash(2, -1),
                              ),
                              TrashRow(
                                trashtype: "페트병",
                                count: provider.plogging.bottleCount,
                                upMethod: () => provider.countTakeTrash(3, 1),
                                downMethod: () =>
                                    provider.countTakeTrash(3, -1),
                              ),
                              TrashRow(
                                trashtype: "유리",
                                count: provider.plogging.glassCount,
                                upMethod: () => provider.countTakeTrash(4, 1),
                                downMethod: () =>
                                    provider.countTakeTrash(4, -1),
                              ),
                            ],
                          );
                        }),
                      ),
                      // 구분선
                      Container(
                        color: greenColor,
                        width: MediaQuery.of(context).size.width,
                        height: 1,
                      ),
                      // 버튼
                      Consumer<PloggingProvider>(
                          builder: (context, porvider, child) {
                        return SizedBox(
                          height: buttonRowHeight,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleButton(
                                icon: Icons.play_arrow_rounded,
                                method: porvider.startPlogging,
                                isActive: porvider.walkingStatus == 0,
                              ),
                              const SizedBox(width: 18),
                              CircleButton(
                                icon: Icons.pause_rounded,
                                method: porvider.pausePlogging,
                                isActive: porvider.walkingStatus == 1,
                              ),
                              const SizedBox(width: 18),
                              CircleButton(
                                icon: Icons.stop_rounded,
                                method: () => porvider.stopPlogging(context),
                                isActive: porvider.walkingStatus == 2,
                              ),
                            ],
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Consumer<PloggingProvider>(builder: (context, provider, child) {
            if (provider.isLoading) {
              return Container(
                color: Colors.black.withOpacity(0.5),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            return Container();
          }),
        ],
      ),
    );
  }
}
