import 'package:flutter/material.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;

class ProsesImage extends StatelessWidget {
  const ProsesImage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ImageComparison(),
    );
  }
}

class ImageComparison extends StatefulWidget {
  const ImageComparison({super.key});

  @override
  State<ImageComparison> createState() => _ImageComparisonState();
}

class _ImageComparisonState extends State<ImageComparison> {
  final ImagePicker picker = ImagePicker();

  img.Image? image1;
  img.Image? image2;

  Future<void> pickImage() async {
    final XFile? pickedFile1 =
        await picker.pickImage(source: ImageSource.gallery);
    final XFile? pickedFile2 =
        await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile1 != null && pickedFile2 != null) {
      final bytes1 = await pickedFile1.readAsBytes();
      final bytes2 = await pickedFile2.readAsBytes();

      setState(() {
        image1 = img.decodeImage(bytes1);
        image2 = img.decodeImage(bytes2);
      });

      // Compare Images
      double similarityPercentage = compareImages(image1!, image2!);

      // Display result to user
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Persentase kesamaan:'),
            content:
                Text('Persamaan dari dua gambar adalah $similarityPercentage%'),
            actions: <Widget>[
              FloatingActionButton(
                child: const Text('Close'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  double compareImages(img.Image imageA, img.Image imageB) {
    // Calculate Mean Squared Error (MSE)
    double mse = 0.0;
    for (int y = 0; y < imageA.height && y < imageB.height; y++) {
      for (int x = 0; x < imageA.width && x < imageB.width; x++) {
        final pixelA = imageA.getPixel(x, y);
        final pixelB = imageB.getPixel(x, y);

        mse += (pixelA.r.toInt() - pixelB.r.toInt());
        /*
         mse += ((img.getRed(pixelA) - img.getRed(pixelB)) * (img.getRed(pixelA) - img.getRed(pixelB)) + (img.getGreen(pixelA) - img.getGreen(pixelB)) * (img.getGreen(pixelA) -
               -) * 
   		(img.geetGreeen(n)(pixelBB))) +* 
   		((i`mg.`gettBlueGettPixepl(pixlelAA)- imge.BluetPixe(lp()))i m *g(et.tBlu((rieemgp.lGe(tApixecl)t)p -ixel(B)));/n*ese / ((doubl`e)(imag`e`.woDutblePixinntss()*()(mag.eHeigDht*(touble)i(mageH)eight));/
  doubl(e)(imag.e.idth);
      }*/
    }
  }
  return 0;
  }


  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
