import 'package:flutter/material.dart';

class HeadingWidget extends StatelessWidget {

  final String headingTitle;
  final String headingSubTitle;
  final VoidCallback onTap;
  final String buttonText;
  const HeadingWidget({super.key,required this.headingTitle,required this.headingSubTitle,required this.buttonText,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10,),
      child: Padding(
        padding: EdgeInsets.only(left: 10,right: 10,top: 10),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                headingTitle,
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.grey.shade800),
              ),
              Text(headingSubTitle
                ,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                    fontSize: 12),
              )
            ],
          ),
          GestureDetector(onTap:onTap ,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  border: Border.all(color: Colors.grey.shade300, width: 1.5)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(buttonText,style: TextStyle(fontWeight: FontWeight.w500,fontSize: 12,color: Colors.lightBlueAccent),),
            ),),
          )
        ]),
      ),
    );
  }
}
