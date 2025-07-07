import 'package:flutter/material.dart';
import '../constants/constants.dart';

/// Common button widget with consistent styling
class CommonButton extends StatelessWidget {
  const CommonButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.isLoading = false,
    this.isEnabled = true,
    this.variant = ButtonVariant.primary,
    this.size = ButtonSize.medium,
    this.icon,
    this.fullWidth = false,
  });

  final VoidCallback? onPressed;
  final String text;
  final bool isLoading;
  final bool isEnabled;
  final ButtonVariant variant;
  final ButtonSize size;
  final IconData? icon;
  final bool fullWidth;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final buttonHeight = _getButtonHeight();
    final fontSize = _getFontSize();
    final padding = _getPadding();

    Widget child = Row(
      mainAxisSize: fullWidth ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (isLoading) ...[
          SizedBox(
            width: UIConstants.iconSM,
            height: UIConstants.iconSM,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation(_getTextColor(theme)),
            ),
          ),
          const SizedBox(width: UIConstants.spacingSM),
        ] else if (icon != null) ...[
          Icon(icon, size: _getIconSize()),
          const SizedBox(width: UIConstants.spacingSM),
        ],
        Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w600,
            color: _getTextColor(theme),
          ),
        ),
      ],
    );

    if (fullWidth) {
      child = SizedBox(width: double.infinity, child: child);
    }

    return SizedBox(
      height: buttonHeight,
      child: ElevatedButton(
        onPressed: isEnabled && !isLoading ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: _getBackgroundColor(theme),
          foregroundColor: _getTextColor(theme),
          elevation: _getElevation(),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(UIConstants.radiusMD),
          ),
          padding: padding,
        ),
        child: child,
      ),
    );
  }

  double _getButtonHeight() {
    switch (size) {
      case ButtonSize.small:
        return UIConstants.buttonHeightSM;
      case ButtonSize.medium:
        return UIConstants.buttonHeightMD;
      case ButtonSize.large:
        return UIConstants.buttonHeightLG;
    }
  }

  double _getFontSize() {
    switch (size) {
      case ButtonSize.small:
        return UIConstants.fontSM;
      case ButtonSize.medium:
        return UIConstants.fontMD;
      case ButtonSize.large:
        return UIConstants.fontLG;
    }
  }

  double _getIconSize() {
    switch (size) {
      case ButtonSize.small:
        return UIConstants.iconXS;
      case ButtonSize.medium:
        return UIConstants.iconSM;
      case ButtonSize.large:
        return UIConstants.iconMD;
    }
  }

  EdgeInsets _getPadding() {
    switch (size) {
      case ButtonSize.small:
        return const EdgeInsets.symmetric(horizontal: UIConstants.spacingSM);
      case ButtonSize.medium:
        return const EdgeInsets.symmetric(horizontal: UIConstants.spacingMD);
      case ButtonSize.large:
        return const EdgeInsets.symmetric(horizontal: UIConstants.spacingLG);
    }
  }

  Color _getBackgroundColor(ThemeData theme) {
    if (!isEnabled || isLoading) {
      return theme.disabledColor;
    }

    switch (variant) {
      case ButtonVariant.primary:
        return theme.primaryColor;
      case ButtonVariant.secondary:
        return theme.colorScheme.secondary;
      case ButtonVariant.outline:
        return Colors.transparent;
      case ButtonVariant.text:
        return Colors.transparent;
    }
  }

  Color _getTextColor(ThemeData theme) {
    if (!isEnabled || isLoading) {
      return theme.colorScheme.onSurface.withOpacity(0.38);
    }

    switch (variant) {
      case ButtonVariant.primary:
        return theme.colorScheme.onPrimary;
      case ButtonVariant.secondary:
        return theme.colorScheme.onSecondary;
      case ButtonVariant.outline:
        return theme.primaryColor;
      case ButtonVariant.text:
        return theme.primaryColor;
    }
  }

  double _getElevation() {
    switch (variant) {
      case ButtonVariant.primary:
      case ButtonVariant.secondary:
        return UIConstants.elevationLow;
      case ButtonVariant.outline:
      case ButtonVariant.text:
        return 0;
    }
  }
}

enum ButtonVariant { primary, secondary, outline, text }

enum ButtonSize { small, medium, large }
