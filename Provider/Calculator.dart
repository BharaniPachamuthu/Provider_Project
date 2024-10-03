import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learning/Provider.dart/CalculatorController.dart';
import 'package:provider/provider.dart';

class claculator extends StatelessWidget {
  const claculator({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CounterScreen(),
    );
  }
}

class CounterScreen extends StatelessWidget {
  CounterScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final pro = Provider.of<Count>(context);
    return ScreenUtilInit(
      designSize: const Size(393, 853),
      builder: (context, child) => Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Consumer<Count>(builder: (context, pod, child) {
                    return Padding(
                      padding: const EdgeInsets.all(10).r,
                      child: Text(
                        pod.display,
                        style: TextStyle(
                            fontSize: 60,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                    ); // Correct string interpolation
                  }),
                ),
              ),
              GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 1,
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 4,
                ),
                itemCount: pro.btn.length,
                itemBuilder: (context, index) {
                  var value = pro.btn[index];
                  return button(context, value);
                },
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
              ),
              SizedBox(
                height: 8.h,
              ),
              Row(
                children: [
                  button(context, "."),
                  const Spacer(),
                  button(context, "0"),
                  const Spacer(),
                  button(context, "=", changewidget: true),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget button(BuildContext context, String value,
      {bool changewidget = false}) {
    return Bounceable(
        scaleFactor: 0.7,
        onTap: () {
          _BtnPress(context, value);
        },
        child: Container(
          height: changewidget ? 80.h : 76.h,
          width: changewidget ? 160.w : 76.w,
          margin: EdgeInsets.all(3),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(60).r,
            color: ['=', '+', '-', '/', '*', '%'].contains(value)
                ? const Color(0xffea8729)
                : Colors.white30,
          ),
          child: Center(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
        ));
  }
}

void _BtnPress(BuildContext context, String button) {
  final pros = Provider.of<Count>(context, listen: false);
  if (button == 'AC') {
    pros.reset();
  } else if (button == '=') {
    pros.calculate();
  } else if (button == 'C') {
    pros.clear();
  } else if (['+', '-', '*', '/', '%'].contains(button)) {
    pros.setOperation(button);
  } else {
    pros.addDigit(button);
  }
}
