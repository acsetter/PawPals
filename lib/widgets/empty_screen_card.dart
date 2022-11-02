import 'package:flutter/material.dart';

class EmptyCard extends StatelessWidget {
  final Color color;

  const EmptyCard({Key? key, required this.color}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(
          top: 30,
          left: 30,
          right:30,
        ),
        child: SizedBox(
            height: MediaQuery.of(context).size.height /1.45,
            width: MediaQuery.of(context).size.width /1.2,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(color: Colors.grey.withOpacity(1.0),
                          spreadRadius: 4,
                          blurRadius: 4,
                          offset: const Offset(3,3),
                        )
                      ]
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      gradient: const LinearGradient(
                        colors: [
                          Color.fromARGB(185, 0, 0, 0),
                          Color.fromARGB(0, 0, 0, 0),
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      )
                  ),
                ),
                Positioned(
                    top:100,
                    left: 50,
                    child:Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            'Loading!\n\n',
                            style: Theme.of(context).textTheme.displayMedium!.copyWith(
                              color: Colors.white,
                            )
                        ),
                        Text(
                            '    Finding the best pets Available \n    '
                                '          Please Wait',
                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                            )
                        ),
                      ],
                    )
                )
              ],
            )
        )
    );
  }
}
