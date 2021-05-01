import 'package:flutter/material.dart';

const double defaultBorderRadius = 3.0;
enum AppleButtonStyle { white, whiteOutline, black }

class GoogleSignInButton extends StatelessWidget {
  final String text;
  final TextStyle textStyle;
  final bool darkMode;
  final double borderRadius;
  final VoidCallback onPressed;
  final Color splashColor;
  final bool centered;

  /// Creates a new button. Set [darkMode] to `true` to use the dark
  /// blue background variant with white text, otherwise an all-white background
  /// with dark text is used.
  GoogleSignInButton(
      { this.onPressed,
        this.text = 'Sign in with Google',
        this.textStyle,
        this.splashColor,
        this.darkMode = false,
        // Google doesn't specify a border radius, but this looks about right.
        this.borderRadius = defaultBorderRadius,
        this.centered = false,
        Key key})
      : assert(text != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return StretchableButton(
      buttonColor: darkMode ? Color(0xFF4285F4) : Colors.white,
      borderRadius: borderRadius,
      splashColor: splashColor,
      onPressed: onPressed,
      buttonPadding: 0.0,
      centered: centered,
      children: <Widget>[
        // The Google design guidelines aren't consistent. The dark mode
        // seems to have a perfect square of white around the logo, with a
        // thin 1dp (ish) border. However, since the height of the button
        // is 40dp and the logo is 18dp, it suggests the bottom and top
        // padding is (40 - 18) * 0.5 = 11. That's 10dp once we account for
        // the thin border.
        //
        // The design guidelines suggest 8dp padding to the left of the
        // logo, which doesn't allow us to center the image (given the 10dp
        // above). Something needs to give - either the 8dp is wrong or the
        // 40dp should be 36dp. I've opted to increase left padding to 10dp.
        //SizedBox(width: 14.0 /* 24.0 - 10dp padding */),
        Padding(
          padding: const EdgeInsets.all(1.0),
          child: Container(
            height: 38.0, // 40dp - 2*1dp border
            width: 38.0, // matches above
            decoration: BoxDecoration(
              color: darkMode ? Colors.white : null,
              borderRadius: BorderRadius.circular(this.borderRadius),
            ),
            child: Center(
              child: Image(
                image: AssetImage(
                  "graphics/google-logo.png",
                  package: "flutter_auth_buttons",
                ),
                height: 18.0,
                width: 18.0,
              ),
            ),
          ),
        ),
        SizedBox(width: 14.0 /* 24.0 - 10dp padding */),
        Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 8.0, 8.0, 8.0),
          child: Text(
            text,
            style: textStyle ??
                TextStyle(
                  fontSize: 16.0,
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.w500,
                  color:
                  darkMode ? Colors.white : Colors.black.withOpacity(0.54),
                ),
          ),
        ),
        SizedBox(width: 14.0 /* 24.0 - 10dp padding */),
      ],
    );
  }
}

class AppleSignInButton extends StatelessWidget {
  final String text;
  final AppleButtonStyle style;
  final double borderRadius;
  final VoidCallback onPressed;
  final TextStyle textStyle;
  final Color splashColor;
  final bool centered;

  /// Creates a new button. Set [darkMode] to `true` to use the dark
  /// black background variant with white text, otherwise an all-white background
  /// with dark text is used.
  AppleSignInButton(
      {this.onPressed,
        // 'Continue with Apple' is also an available variant depdening on App's sign-in experience.
        this.text = 'Sign in with Apple',
        this.textStyle,
        this.splashColor,
        this.style = AppleButtonStyle.white,
        // Apple doesn't specify a border radius, but this looks about right.
        this.borderRadius = defaultBorderRadius,
        this.centered = false,
        Key key})
      : assert(text != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return StretchableButton(
      buttonColor:
      style == AppleButtonStyle.black ? Colors.black : Colors.white,
      borderRadius: borderRadius,
      splashColor: splashColor,
      buttonBorderColor:
      style == AppleButtonStyle.whiteOutline ? Colors.black : null,
      onPressed: onPressed,
      buttonPadding: 0.0,
      centered: centered,
      children: <Widget>[
        Center(
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 4.0, bottom: 3.0),
                child: Container(
                  height: 38.0,
                  width: 32.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(this.borderRadius),
                  ),
                  child: Center(
                    child: Image(
                      image: AssetImage(
                        "graphics/apple_logo_${style == AppleButtonStyle.black ? "white" : "black"}.png",
                        package: "flutter_auth_buttons",
                      ),
                      height: 17.0,
                      width: 17.0,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 18),
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 8.0, 32.0, 8.0),
                child: Text(
                  text,
                  style: textStyle ??
                      TextStyle(
                        fontSize: 16.0,
                        fontFamily: "SF Pro",
                        fontWeight: FontWeight.w500,
                        color: style == AppleButtonStyle.black
                            ? Colors.white
                            : Colors.black,
                      ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class FacebookSignInButton extends StatelessWidget {
  final String text;
  final TextStyle textStyle;
  final VoidCallback onPressed;
  final double borderRadius;
  final Color splashColor;
  final bool centered;

  /// Creates a new button. The default button text is 'Continue with Facebook',
  /// which apparently results in higher conversion. 'Login with Facebook' is
  /// another suggestion.
  FacebookSignInButton({
    this.onPressed,
    this.borderRadius = defaultBorderRadius,
    this.text = 'Continue with Facebook',
    this.textStyle,
    this.splashColor,
    this.centered = false,
    Key key,
  })  : assert(text != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return StretchableButton(
      buttonColor: Color(0xFF1877F2),
      borderRadius: borderRadius,
      splashColor: splashColor,
      onPressed: onPressed,
      buttonPadding: 8.0,
      centered: centered,
      children: <Widget>[
        // Facebook doesn't provide strict sizes, so this is a good
        // estimate of their examples within documentation.

        Image(
          image: AssetImage(
            "graphics/flogo-HexRBG-Wht-100.png",
            package: "flutter_auth_buttons",
          ),
          height: 24.0,
          width: 24.0,
        ),
        SizedBox(width: 8),
        Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 0.0),
          child: Text(
            text,
            style: textStyle ??
                TextStyle(
                  // default to the application font-style
                  fontSize: 16.0,
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
          ),
        ),
      ],
    );
  }
}

class SpraatSignInButton extends StatelessWidget {
  final String text;
  final TextStyle textStyle;
  final VoidCallback onPressed;
  final double borderRadius;
  final Color buttonColor;
  final Color splashColor;
  final bool centered;
  final double padding;

  /// Creates a new button. The default button text is 'Continue with Facebook',
  /// which apparently results in higher conversion. 'Login with Facebook' is
  /// another suggestion.
  SpraatSignInButton({
    this.onPressed,
    this.borderRadius = defaultBorderRadius,
    this.text = 'Sign In',
    this.textStyle,
    this.buttonColor = const Color(0xFF226B95),
    this.splashColor,
    this.centered = false,
    this.padding = 10,
    Key key,
  })  : assert(text != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return StretchableButton(
      buttonColor: buttonColor,
      borderRadius: borderRadius,
      splashColor: splashColor,
      onPressed: onPressed,
      buttonPadding: 8.0,
      centered: centered,
      children: <Widget>[
        // Facebook doesn't provide strict sizes, so this is a good
        // estimate of their examples within documentation.

        SizedBox(width: 24),
        Padding(
          padding: EdgeInsets.only(left: padding, right: padding),
          child: Text(
            text,
            style: textStyle ??
                TextStyle(
                  // default to the application font-style
                  fontSize: 16.0,
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
          ),
        ),
        SizedBox(width: 24),
      ],
    );
  }
}

class StretchableButton extends StatelessWidget {
  final VoidCallback onPressed;
  final double borderRadius;
  final double buttonPadding;
  final Color buttonColor, splashColor;
  final Color buttonBorderColor;
  final List<Widget> children;
  final bool centered;

  StretchableButton({
    @required this.buttonColor,
    @required this.borderRadius,
    @required this.children,
    this.splashColor,
    this.buttonBorderColor,
    this.onPressed,
    this.buttonPadding,
    this.centered = false,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        var contents = List<Widget>.from(children);

        //new code
        contents.insert(0,SizedBox(width: 24));
        contents.add(SizedBox(width: 24));

        if (constraints.minWidth == 0) {
          contents.add(SizedBox.shrink());
        } else {
          if (centered) {
            contents.insert(0, Spacer());
          }
          contents.add(Spacer());
        }

        BorderSide bs;
        if (buttonBorderColor != null) {
          bs = BorderSide(
            color: buttonBorderColor,
          );
        } else {
          bs = BorderSide.none;
        }

        return ButtonTheme(
          height: 42.0,
          padding: EdgeInsets.all(buttonPadding),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: bs,
          ),
          child: RaisedButton(
            onPressed: onPressed,
            color: buttonColor,
            splashColor: splashColor,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: contents
            ),
          ),
        );
      },
    );
  }
}

