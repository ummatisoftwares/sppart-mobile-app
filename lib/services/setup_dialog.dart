// import 'package:flutter/material.dart';
// import 'package:stacked_services/stacked_services.dart';
// import 'package:tkhayal_stacked/app/locator.dart';

// void setupDialogUi() {
//   var dialogService = locator<DialogService>();

//   // ignore: deprecated_member_use
//   dialogService.registerCustomDialogUi((context, dialogRequest) {
//     String code;
//     return Dialog(
//       child: Container(
//         padding: const EdgeInsets.all(20),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisSize: MainAxisSize.min,
//           children: <Widget>[
//             Text(
//               dialogRequest.title,
//               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             Text(
//               dialogRequest.description,
//               style: TextStyle(
//                 fontSize: 18,
//               ),
//               textAlign: TextAlign.center,
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             dialogRequest.takesInput
//                 ? TextFormField(
//                     onChanged: (value) => code = value,
//                     decoration: InputDecoration(hintText: 'Code'),
//                   )
//                 : Container(),
//             GestureDetector(
//               // Complete the dialog when you're done with it to return some data
//               onTap: () => dialogService.completeDialog(
//                   DialogResponse(confirmed: true, responseData: code)),
//               child: Container(
//                 child: dialogRequest.showIconInMainButton
//                     ? Icon(Icons.check_circle)
//                     : Text(dialogRequest.mainButtonTitle),
//                 alignment: Alignment.center,
//                 padding: const EdgeInsets.symmetric(vertical: 10),
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                   color: Colors.redAccent,
//                   borderRadius: BorderRadius.circular(5),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   });
// }
