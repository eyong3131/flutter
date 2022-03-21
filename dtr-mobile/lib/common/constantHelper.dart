// ignore_for_file: unnecessary_new, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minhs/common/sizeHelper.dart';

const kPrimaryColor = Color(0xff021A3C);
const kLightColor = Color(0xff324067);
const kNoImage =
    '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E3XHY0Aed0V31xoHh+6maYStEWOSqPgZ+mOKi/4RfQP+fub/AL+f/WoA4Y9K9EvVMdhp0ZGGWAAj04FQQaJ4fsJluA7zshyqs2Rn6UXdy13cGRuB0UegoAgooooAKKKKAClpKWgAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigDGk8S2MN09vIk4KOUZtowMHGeucfhWzXCyWTX2q6oiZMkZkkQDuQ44/In8cV0Phu++16aIWP7y3wh91/h/wAPwoAtf2tB/a39nbJPO/vYG37u71z09qv1zH/M9f5/55Vu32oW2nxCS4k25ztUDJY+1AFqiuZbxeodglkSueCZcEj6YrY0/VrTUgRA5DgZaNxhgP8APp60AXqqahqEOm26zTK7Kz7AEAJzgnufardYPiz/AJBUX/Xcf+gtQAf8JZYf88rn/vlf8as2fiGxvZhCpeN2OFEgxuPsQT+tQ6FY2k2i28ktrA7ndlmjBJ+Y1leJ7G3tJoJYIxH5oYMqjC8Y5A7daAOworOfUHttBjvpF81/KRmGduSce3vWY/i2MRRlLUs7Al134C88DOOfWgDpKKp3upwafbLNcblL/djGCxPfvjj61ir4vUuoeyIXPJEuSB9MUAdNRVSLUI7nTmu7UGXCEiMfe3Afd+tVdI1pdVeVDCImjAIG/cWHfsOnH50AatQXt3HY2j3MoYomMhRzycf1qtq2qLpVukhjEjO+0Jv2nGOT0+n51FNqKv4fN9PZhlYAmBzkEbsDqPoelAFrT9Qh1K3aaFXVVfYQ4AOcA9j71brM0S7hvLJ5IbVLZRIVKJjBOBzwB6/pVO88U29vMY7eEz7Thn3bV/DrmgDforF07xHb30wgkjMErHC5bKn2z60t/r39n6kttNbYjbafN8z+E9TjHbn8qANmiquo3n2CwkufL8zZj5c4zkgdfxqLSdS/tS1afyvK2uUxu3dgfQetAF+isb+3t+s/2fDbeZ8+wyeZjGPvcEdufritmgAooooAKKKKACiiigAooooA5jRf+Rp1D/tp/wChioph/YHiNZgNtrP1wOAp6jp2POB2x61Lov8AyNOof9tP/QxWnr1h9v01ti5mi+dMDk+o6Z5Hb1xQBmf8z1/n/nlVbW2a98SR2krERK6RgKegbBJ+vP6Cq2gyPLr9qznJClenYIQP0Fa3iDSbma5S+s1y6r8wThsjkMPU9vXgUAb0dtDFbC3SJRCF27MZGP61yKqNK8WLDbZEZkVNpJPysBkfhnj6CrC+K7iKHyprQG4UFWYtt+b3XH5jP5VJo2l3k+pf2jqCMMfMvmdWbp07Afh2xQB09YPiz/kFRf8AXcf+gtW9WD4s/wCQVF/13H/oLUAZmnf2/wDYI/sX/Hvzs/1fqc9eeuamXQdT1G6WfUpQgzhvmBbaPQDgf/rNa/h3/kBW3/Av/QjWpQBla+qp4fnRFCqoQAAYAG4VneGLC2nspppoUlYybAJFDAAAHjP1/lWl4i/5AVz/AMB/9CFVfCf/ACCpf+u5/wDQVoAyNdkaTxGUdDMqFFWMcFhgHbxzySfzrSk1W4ltjbv4fnMJXbs+YDH/AHzxTfEOkztcrqFmrM/G9UzuBHRh+nT0+tQr4um8nDWiGXB+YOQue3H/ANegB3hiC8tr2ZZYJYonjyd8ZALAjHJHuaZGjaR4sCYxDO2FCqPuseBjsA38q19EfVJYWk1DAUn5AybX/HpgfhmqniqzElml2q/PE21jx90+vrzj8zQBU1zfqevwafGSAgAOQOCeSffjH5Vra+qp4fnRFCqoQAAYAG4Vm+GoHur651OVV5YgYH8ROTjuMD+dafiL/kBXP/Af/QhQBiWMjxeD75kOCZdvTsdoP6GotDvJbKKR4dLkuXZsGVM8Dj5eh+v5Vf0C1S98PXVs5wJJSM+hwuD+BqhbXd94cnkhmg3xO3QkgNgdVPTuM8enSgBNWF1qcyTLpFxDIBh2CMd/p2HSrniG3kl0myvJFPnKirL8mDyO/pg9vehNb1TU7uJLCARopG/PzL/wI44HHbnrW/e2pvNNltnKs7pjPKjd2P0z9aAOd1i8fUNN0uCNlklnwzdjvHy/gMlvyqXSZE0vWtRtpNsUIUuMnJwvIx6/KSfXiqPh2M3erQ+YQVtoyyqVB7/4tnNWvFMZt76G6iIVpY2jbCjnjBP4hsfhQAvheF7m+ub+b5mHAYp1ZjkkHsf/AIquqrM0G1Fro8IwN0g8xiCec9P0xWnQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQB//Z';

final otpInputDecoration = InputDecoration(
  contentPadding:
      EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15)),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(15),
    ),
    borderSide: BorderSide(color: kLightColor),
  );
}

Widget kSuccessDialog(context, message) {
  if (message.toString().length > 80) {
    message = message.toString().substring(0, 80);
  }

  return Dialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
    child: Stack(
      overflow: Overflow.visible,
      alignment: Alignment.topCenter,
      children: [
        SizedBox(
          height: 260,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 70, 10, 15),
            child: Column(
              children: [
                Text(
                  'SUCESS',
                  style: GoogleFonts.lato(
                    fontSize: 24.0,
                    color: Colors.greenAccent,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  message,
                  style: GoogleFonts.lato(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 150,
                  height: 50,
                  child: ElevatedButton(
                    child: Text(
                      "OK",
                      style: GoogleFonts.lato(
                        fontSize: 20.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(kLightColor),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: -50,
          child: ClipRRect(
            child: Image.asset(
              "assets/images/logo.png",
              fit: BoxFit.fill,
              height: 100,
              width: 100,
            ),
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
      ],
    ),
  );
}

Widget kErrorDialog(context, message) {
  if (message.toString().length > 80) {
    message = message.toString().substring(0, 80);
  }

  return Dialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
    child: Stack(
      overflow: Overflow.visible,
      alignment: Alignment.topCenter,
      children: [
        SizedBox(
          height: 250,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 70, 10, 15),
            child: Column(
              children: [
                Text(
                  'ERROR',
                  style: GoogleFonts.lato(
                    fontSize: 24.0,
                    color: Colors.redAccent,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  message,
                  style: GoogleFonts.lato(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 150,
                  height: 50,
                  child: ElevatedButton(
                    child: Text(
                      "OK",
                      style: GoogleFonts.lato(
                        fontSize: 20.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(kLightColor),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: -50,
          child: ClipRRect(
            child: Image.asset(
              "assets/images/logo.png",
              fit: BoxFit.fill,
              height: 100,
              width: 100,
            ),
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
      ],
    ),
  );
}
