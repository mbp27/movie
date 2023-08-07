import 'package:flutter/material.dart';
import 'package:movie/helpers/utils.dart';
import 'package:movie/presentation/components/custom_shimmer.dart';

class ReviewLoadingWidget extends StatelessWidget {
  const ReviewLoadingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomShimmer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Container(
                  color: Colors.black,
                  height: 14.0,
                  width: 100.0,
                ),
              ),
              const SizedBox(height: 4.0),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Container(
                      color: Colors.black,
                      height: 14.0,
                      width: 70.0,
                    ),
                  ),
                  const SizedBox(width: 4.0),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Container(
                      color: Colors.black,
                      height: 12.0,
                      width: 70.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [null, null, null, Utils.size(context).width / 2]
                    .map((e) => Padding(
                          padding: const EdgeInsets.only(bottom: 4.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Container(
                              color: Colors.black,
                              height: 12.0,
                              width: e,
                            ),
                          ),
                        ))
                    .toList(),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Container(
                    color: Colors.black,
                    height: 12.0,
                    width: 60,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
