import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PinPut extends StatefulWidget {
  const PinPut({
    Key? key,
    required this.fieldsCount,
    this.onSubmit,
    this.onSaved,
    this.onChanged,
    this.onTap,
    this.onClipboardFound,
    this.controller,
    this.focusNode,
    this.preFilledWidget,
    this.separatorPositions = const <int>[],
    this.separator = const SizedBox(width: 15.0),
    this.textStyle,
    this.submittedFieldDecoration,
    this.selectedFieldDecoration,
    this.followingFieldDecoration,
    this.disabledDecoration,
    this.eachFieldWidth,
    this.eachFieldHeight,
    this.fieldsAlignment = MainAxisAlignment.spaceBetween,
    this.eachFieldAlignment = Alignment.center,
    this.eachFieldMargin,
    this.eachFieldPadding,
    this.eachFieldConstraints = const BoxConstraints(minHeight: 40.0, minWidth: 40.0),
    this.inputDecoration = const InputDecoration(
      contentPadding: EdgeInsets.zero,
      border: InputBorder.none,
      counterText: '',
    ),
    this.animationCurve = Curves.linear,
    this.animationDuration = const Duration(milliseconds: 160),
    this.pinAnimationType = PinAnimationType.slide,
    this.slideTransitionBeginOffset,
    this.enabled = true,
    this.checkClipboard = false,
    this.useNativeKeyboard = true,
    this.autofocus = false,
    this.autovalidateMode = AutovalidateMode.disabled,
    this.withCursor = false,
    this.cursor,
    this.keyboardAppearance,
    this.inputFormatters,
    this.validator,
    this.keyboardType = TextInputType.number,
    this.obscureText,
    this.textCapitalization = TextCapitalization.none,
    this.textInputAction,
    this.toolbarOptions,
    this.mainAxisSize = MainAxisSize.max,
  })  : assert(fieldsCount > 0),
        super(key: key);

  /// Displayed fields count. PIN code length.
  final int fieldsCount;

  /// Same as FormField onFieldSubmitted, called when PinPut submitted.
  final ValueChanged<String>? onSubmit;

  /// Signature for being notified when a form field changes value.
  final FormFieldSetter<String>? onSaved;

  /// Called every time input value changes.
  final ValueChanged<String>? onChanged;

  /// Called when user clicks on PinPut
  final VoidCallback? onTap;

  /// Called when Clipboard has value of length fieldsCount.
  final ValueChanged<String?>? onClipboardFound;

  /// Used to get, modify PinPut value and more.
  final TextEditingController? controller;

  /// Defines the keyboard focus for this widget.
  /// To give the keyboard focus to this widget, provide a [focusNode] and then
  /// use the current [FocusScope] to request the focus:
  final FocusNode? focusNode;

  /// Widget that is displayed before field submitted.
  final Widget? preFilledWidget;

  /// Sets the positions where the separator should be shown
  final List<int> separatorPositions;

  /// Builds a PinPut separator
  final Widget separator;

  /// The style to use for PinPut
  /// If null, defaults to the `subhead` text style from the current [Theme].
  final TextStyle? textStyle;

  ///  Box decoration of following properties of [PinPut]
  ///  [submittedFieldDecoration] [selectedFieldDecoration] [followingFieldDecoration] [disabledDecoration]
  ///  You can customize every pixel with it
  ///  properties are being animated implicitly when value changes
  ///  ```dart
  ///  this.color,
  ///  this.image,
  ///  this.border,
  ///  this.borderRadius,
  ///  this.boxShadow,
  ///  this.gradient,
  ///  this.backgroundBlendMode,
  ///  this.shape = BoxShape.rectangle,
  ///  ```

  /// The decoration of each [PinPut] submitted field
  final BoxDecoration? submittedFieldDecoration;

  /// The decoration of [PinPut] currently selected field
  final BoxDecoration? selectedFieldDecoration;

  /// The decoration of each [PinPut] following field
  final BoxDecoration? followingFieldDecoration;

  /// The decoration of each [PinPut] field when [PinPut] ise disabled
  final BoxDecoration? disabledDecoration;

  /// width of each [PinPut] field
  final double? eachFieldWidth;

  /// height of each [PinPut] field
  final double? eachFieldHeight;

  /// Defines how [PinPut] fields are being placed inside [Row]
  final MainAxisAlignment fieldsAlignment;

  /// Defines how each [PinPut] field are being placed within the container
  final AlignmentGeometry eachFieldAlignment;

  /// Empty space to surround the [PinPut] field container.
  final EdgeInsetsGeometry? eachFieldMargin;

  /// Empty space to inscribe the [PinPut] field container.
  /// For example space between border and text
  final EdgeInsetsGeometry? eachFieldPadding;

  /// Additional constraints to apply to the each field container.
  /// properties
  /// ```dart
  ///  this.minWidth = 0.0,
  ///  this.maxWidth = double.infinity,
  ///  this.minHeight = 0.0,
  ///  this.maxHeight = double.infinity,
  ///  ```
  final BoxConstraints eachFieldConstraints;

  /// The decoration to show around the text [PinPut].
  ///
  /// can be configured to show an icon, border,counter, label, hint text, and error text.
  /// set counterText to '' to remove bottom padding entirely
  final InputDecoration inputDecoration;

  /// curve of every [PinPut] Animation
  final Curve animationCurve;

  /// Duration of every [PinPut] Animation
  final Duration animationDuration;

  /// Animation Type of each [PinPut] field
  /// options:
  /// none, scale, fade, slide, rotation
  final PinAnimationType pinAnimationType;

  /// Begin Offset of ever [PinPut] field when [pinAnimationType] is slide
  final Offset? slideTransitionBeginOffset;

  /// Defines [PinPut] state
  final bool enabled;

  /// {@macro flutter.widgets.editableText.autofocus}
  final bool autofocus;

  /// Whether we should check [Clipboard] data
  final bool checkClipboard;

  /// Whether we use Native keyboard or custom `Numpad`
  /// when flag is set to false [PinPut] wont be focusable anymore
  /// so you should set value of [PinPut]'s [TextEditingController] programmatically
  final bool useNativeKeyboard;

  /// If true [validator] function is called when [PinPut] value changes
  /// alternatively you can use [GlobalKey]
  /// ```dart
  ///   final _formKey = GlobalKey<FormState>();
  ///   _formKey.currentState.validate()
  /// ```
  final AutovalidateMode autovalidateMode;

  /// If true the focused field includes fake cursor
  final bool withCursor;

  /// If [withCursor] true the focused field includes cursor widget or '|'
  final Widget? cursor;

  /// The appearance of the keyboard.
  /// This setting is only honored on iOS devices.
  /// If unset, defaults to the brightness of [ThemeData.primaryColorBrightness].
  final Brightness? keyboardAppearance;

  /// {@macro flutter.widgets.editableText.inputFormatters}
  final List<TextInputFormatter>? inputFormatters;

  /// An optional method that validates an input. Returns an error string to
  /// display if the input is invalid, or null otherwise.
  ///
  /// The returned value is exposed by the [FormFieldState.errorText] property.
  /// The [TextFormField] uses this to override the [InputDecoration.errorText]
  /// value.
  ///
  /// Alternating between error and normal state can cause the height of the
  /// [TextFormField] to change if no other subtext decoration is set on the
  /// field. To create a field whose height is fixed regardless of whether or
  /// not an error is displayed, either wrap the  [TextFormField] in a fixed
  /// height parent like [SizedBox], or set the [TextFormField.helperText]
  /// parameter to a space.
  final FormFieldValidator<String>? validator;

  /// {@macro flutter.widgets.editableText.keyboardType}
  final TextInputType keyboardType;

  /// Provide any symbol to obscure each [PinPut] field
  /// Recommended ●
  final String? obscureText;

  /// {@macro flutter.widgets.editableText.textCapitalization}
  final TextCapitalization textCapitalization;

  /// The type of action button to use for the keyboard.
  ///
  /// Defaults to [TextInputAction.newline] if [keyboardType] is
  /// [TextInputType.multiline] and [TextInputAction.done] otherwise.
  final TextInputAction? textInputAction;

  /// Configuration of toolbar options.
  ///
  /// If not set, select all and paste will default to be enabled. Copy and cut
  /// will be disabled if [obscureText] is true. If [readOnly] is true,
  /// paste and cut will be disabled regardless.
  final ToolbarOptions? toolbarOptions;

  /// Maximize the amount of free space along the main axis.
  final MainAxisSize mainAxisSize;

  @override
  PinPutState createState() => PinPutState();
}

enum PinAnimationType {
  none,
  scale,
  fade,
  slide,
  rotation,
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}

class PinPutState extends State<PinPut> with WidgetsBindingObserver, SingleTickerProviderStateMixin {
  TextEditingController? _controller;
  FocusNode? _focusNode;
  ValueNotifier<String>? _textControllerValue;

  int get selectedIndex => _controller!.value.text.length;

  late Animation<double> _cursorAnimation;
  AnimationController? _cursorAnimationController;

  @override
  void initState() {
    _controller = widget.controller ?? TextEditingController();
    if (!widget.useNativeKeyboard) {
      _focusNode = AlwaysDisabledFocusNode();
    } else {
      _focusNode = widget.focusNode ?? FocusNode();
    }
    _textControllerValue = ValueNotifier<String>(_controller!.value.text);
    _controller?.addListener(_textChangeListener);
    _focusNode?.addListener(() {
      if (mounted) setState(() {});
    });

    if (widget.withCursor) {
      _cursorAnimationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
      _cursorAnimation = Tween<double>(begin: 0.0, end: 1.0)
          .animate(CurvedAnimation(curve: Curves.linear, parent: _cursorAnimationController!));

      _cursorAnimationController!.addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          _cursorAnimationController!.repeat(reverse: true);
        }
      });
      _cursorAnimationController!.forward();
    }

    WidgetsBinding.instance?.addObserver(this);
    super.initState();
  }

  void _textChangeListener() {
    final String pin = _controller!.value.text;
    widget.onChanged?.call(pin);
    if (pin != _textControllerValue!.value) {
      try {
        _textControllerValue!.value = pin;
      } catch (e) {
        _textControllerValue = ValueNotifier<String>(_controller!.value.text);
      }
      if (pin.length == widget.fieldsCount) widget.onSubmit?.call(pin);
    }
  }

  @override
  void dispose() {
    if (widget.controller == null) _controller!.dispose();
    if (widget.focusNode == null) _focusNode!.dispose();

    _cursorAnimationController?.dispose();
    _textControllerValue?.dispose();
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState appLifecycleState) {
    if (appLifecycleState == AppLifecycleState.resumed || widget.checkClipboard) {
      _checkClipboard();
    }
  }

  Future<void> _checkClipboard() async {
    final ClipboardData? clipboardData = await Clipboard.getData('text/plain');
    if (clipboardData?.text?.length == widget.fieldsCount) {
      widget.onClipboardFound?.call(clipboardData!.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        _hiddenTextField,
        _fields,
      ],
    );
  }

  void _handleTap() {
    final FocusScopeNode focus = FocusScope.of(context);
    if (_focusNode!.hasFocus) _focusNode!.unfocus();
    if (focus.hasFocus) focus.unfocus();
    focus.requestFocus(FocusNode());
    Future<void>.delayed(Duration.zero, () => focus.requestFocus(_focusNode));
    widget.onTap?.call();
  }

  Widget get _hiddenTextField {
    return TextFormField(
      controller: _controller,
      onTap: widget.onTap,
      onSaved: widget.onSaved,
      onChanged: widget.onChanged,
      validator: widget.validator,
      autovalidateMode: widget.autovalidateMode,
      textInputAction: widget.textInputAction,
      focusNode: _focusNode,
      enabled: widget.enabled,
      enableSuggestions: false,
      autofocus: widget.autofocus,
      obscureText: widget.obscureText != null,
      autocorrect: false,
      keyboardAppearance: widget.keyboardAppearance,
      keyboardType: widget.keyboardType,
      textCapitalization: widget.textCapitalization,
      inputFormatters: widget.inputFormatters,
      enableInteractiveSelection: false,
      maxLength: widget.fieldsCount,
      showCursor: false,
      scrollPadding: EdgeInsets.zero,
      decoration: widget.inputDecoration,
      style: widget.textStyle != null
          ? widget.textStyle!.copyWith(color: Colors.transparent)
          : const TextStyle(color: Colors.transparent),
    );
  }

  Widget get _fields {
    return ValueListenableBuilder<String>(
      valueListenable: _textControllerValue!,
      builder: (BuildContext context, String value, Widget? child) {
        return GestureDetector(
          onTap: _handleTap,
          child: Row(
            mainAxisSize: widget.mainAxisSize,
            mainAxisAlignment: widget.fieldsAlignment,
            children: _buildFieldsWithSeparator(),
          ),
        );
      },
    );
  }

  List<Widget> _buildFieldsWithSeparator() {
    final List<Widget> fields = Iterable<int>.generate(widget.fieldsCount).map((int index) {
      return _getField(index);
    }).toList();

    for (final int i in widget.separatorPositions) {
      if (i <= widget.fieldsCount) {
        final List<int> smaller = widget.separatorPositions.where((int d) => d < i).toList();
        fields.insert(i + smaller.length, widget.separator);
      }
    }

    return fields;
  }

  Widget _getField(int index) {
    final String pin = _controller!.value.text;
    return AnimatedContainer(
      width: widget.eachFieldWidth,
      height: widget.eachFieldHeight,
      alignment: widget.eachFieldAlignment,
      duration: widget.animationDuration,
      curve: widget.animationCurve,
      padding: widget.eachFieldPadding,
      margin: widget.eachFieldMargin,
      constraints: widget.eachFieldConstraints,
      decoration: _fieldDecoration(index),
      child: AnimatedSwitcher(
        switchInCurve: widget.animationCurve,
        switchOutCurve: widget.animationCurve,
        duration: widget.animationDuration,
        transitionBuilder: (Widget child, Animation<double> animation) {
          return _getTransition(child, animation);
        },
        child: _buildFieldContent(index, pin),
      ),
    );
  }

  Widget _buildFieldContent(int index, String pin) {
    if (index < pin.length) {
      return Text(
        widget.obscureText ?? pin[index],
        key: ValueKey<String>(index < pin.length ? pin[index] : ''),
        style: widget.textStyle,
      );
    }

    final bool isActiveField = index == pin.length;
    final bool focused = _focusNode!.hasFocus || !widget.useNativeKeyboard;

    if (widget.withCursor && isActiveField && focused) {
      return _buildCursor();
    }

    if (widget.preFilledWidget != null) {
      return SizedBox(
        key: ValueKey<String>(index < pin.length ? pin[index] : ''),
        child: widget.preFilledWidget,
      );
    }
    return Text(
      '',
      key: ValueKey<String>(index < pin.length ? pin[index] : ''),
      style: widget.textStyle,
    );
  }

  BoxDecoration? _fieldDecoration(int index) {
    if (!widget.enabled) return widget.disabledDecoration;
    if (index < selectedIndex && _focusNode!.hasFocus) {
      return widget.submittedFieldDecoration;
    }
    if (index == selectedIndex && _focusNode!.hasFocus) {
      return widget.selectedFieldDecoration;
    }
    return widget.followingFieldDecoration;
  }

  Widget _getTransition(Widget child, Animation<double> animation) {
    switch (widget.pinAnimationType) {
      case PinAnimationType.none:
        return child;
      case PinAnimationType.fade:
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      case PinAnimationType.scale:
        return ScaleTransition(
          scale: animation,
          child: child,
        );
      case PinAnimationType.slide:
        return SlideTransition(
          position: Tween<Offset>(
            begin: widget.slideTransitionBeginOffset ?? const Offset(0.8, 0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      case PinAnimationType.rotation:
        return RotationTransition(
          turns: animation,
          child: child,
        );
    }
  }

  Widget _buildCursor() {
    return AnimatedBuilder(
      animation: _cursorAnimationController!,
      builder: (BuildContext context, Widget? child) {
        return Center(
          child: Opacity(
            opacity: _cursorAnimation.value,
            child: widget.cursor ?? Text('|', style: widget.textStyle),
          ),
        );
      },
    );
  }
}
