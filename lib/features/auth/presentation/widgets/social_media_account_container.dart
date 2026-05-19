import 'package:flutter/material.dart';
import 'package:test_firbase_project/features/auth/presentation/page/utilitis/colors.dart';

class SocialMediaAccountContainer extends StatelessWidget {
   final String text;
   final String image;
  const SocialMediaAccountContainer({super.key,
   required this.text, required this.image});

  @override
  Widget build(BuildContext context) {
     return Expanded(
      child: Container(
        margin: EdgeInsets.all(13),
        padding: EdgeInsets.symmetric(horizontal: 14),
        height: 50,
        decoration: BoxDecoration(
          color: AppColors.containerColor,
      
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Image.asset(
              image, fit: 
              BoxFit.cover, 
              height: 30, 
              width: 30,
               errorBuilder: (context, e, stackTrace){
                 return Icon(Icons.error, color: Colors.red,);
               },),
      
            const SizedBox(width: 7),
      
            Expanded(
              child: Text(
                text,
                style: TextStyle(fontSize: 18, color: AppColors.textColors), 
              ),
            ),
          ],
        ),
      ),
    );
  }
}