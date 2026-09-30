import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../common_app_bar.dart';
import '../movielog_text_form_field.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import 'login_prompt.dart';
import 'sign_up_button.dart';
import 'sign_up_header.dart';
import 'sign_up_validators.dart';
import 'terms_agreement_checkbox.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // 이 너비 이상이면 Form을 가운데 정렬하고 최대 너비를 제한합니다.
  static const double _wideBreakpoint = 700;
  static const double _maxFormWidth = 560;

  final _formKey = GlobalKey<FormState>();

  final _nicknameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  bool _agreedToTerms = false;
  bool _obscurePassword = true;

  bool get _canSubmit =>
      SignUpValidators.nickname(_nicknameController.text) == null &&
      SignUpValidators.email(_emailController.text) == null &&
      SignUpValidators.password(_passwordController.text) == null &&
      _agreedToTerms;

  @override
  void dispose() {
    _nicknameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  void _submit() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    FocusScope.of(context).unfocus();
    debugPrint('가입하기 버튼을 눌렀습니다: ${_nicknameController.text.trim()}');
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= _wideBreakpoint;

        return Scaffold(
          // 넓은 화면 Figma에는 AppBar가 없고 제목이 본문에 있습니다.
          appBar: isWide
              ? null
              : CommonAppBar(
                  title: '회원가입',
                  centerTitle: true,
                  onBack: () => Navigator.maybePop(context),
                ),
          body: SafeArea(
            child: LayoutBuilder(
              builder: (context, bodyConstraints) {
                return Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: isWide ? _maxFormWidth : double.infinity,
                    ),
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(
                        horizontal: isWide ? AppSpacing.lg : AppSpacing.sm,
                      ),
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      child: ConstrainedBox(
                        // 휴대폰에서는 화면 높이를 채워 약관·버튼을 하단에 배치하고,
                        // 넓은 화면에서는 내용 높이만큼만 차지해 세로 가운데 정렬합니다.
                        constraints: BoxConstraints(
                          minHeight: isWide ? 0 : bodyConstraints.maxHeight,
                        ),
                        child: IntrinsicHeight(child: _buildForm(isWide)),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildForm(bool isWide) {
    final fieldGap = isWide ? AppSpacing.md : AppSpacing.sm;

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: AppSpacing.lg),
          SignUpHeader(isWide: isWide),
          SizedBox(height: isWide ? 40 : AppSpacing.xl),
          MovieLogTextFormField(
            label: '닉네임',
            hintText: isWide ? '영화로운 닉네임을 입력하세요' : '닉네임을 입력해주세요',
            controller: _nicknameController,
            validator: SignUpValidators.nickname,
            textInputAction: TextInputAction.next,
            compact: isWide,
            onChanged: (_) => setState(() {}),
            onFieldSubmitted: (_) => _emailFocusNode.requestFocus(),
          ),
          SizedBox(height: fieldGap),
          MovieLogTextFormField(
            label: isWide ? '이메일 주소' : '이메일',
            hintText: isWide ? 'example@movielog.com' : '이메일 주소를 입력해주세요',
            controller: _emailController,
            focusNode: _emailFocusNode,
            validator: SignUpValidators.email,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            compact: isWide,
            onChanged: (_) => setState(() {}),
            onFieldSubmitted: (_) => _passwordFocusNode.requestFocus(),
          ),
          SizedBox(height: fieldGap),
          MovieLogTextFormField(
            label: '비밀번호',
            hintText: isWide ? '영문, 숫자 포함 8자 이상' : '비밀번호를 입력해주세요',
            controller: _passwordController,
            focusNode: _passwordFocusNode,
            validator: SignUpValidators.password,
            keyboardType: TextInputType.visiblePassword,
            textInputAction: TextInputAction.done,
            obscureText: _obscurePassword,
            compact: isWide,
            onChanged: (_) => setState(() {}),
            onFieldSubmitted: (_) => FocusScope.of(context).unfocus(),
            trailing: _buildPasswordToggle(),
          ),
          const SizedBox(height: AppSpacing.lg),
          // 휴대폰에서는 남은 높이를 채워 약관·버튼을 하단으로 밀어냅니다.
          if (!isWide) const Spacer(),
          TermsAgreementCheckbox(
            value: _agreedToTerms,
            isWide: isWide,
            onChanged: (value) {
              setState(() {
                _agreedToTerms = value;
              });
            },
          ),
          SizedBox(height: isWide ? AppSpacing.lg : AppSpacing.md),
          SignUpButton(onPressed: _canSubmit ? _submit : null),
          const SizedBox(height: AppSpacing.md),
          LoginPrompt(isWide: isWide),
          const SizedBox(height: AppSpacing.md),
        ],
      ),
    );
  }

  Widget _buildPasswordToggle() {
    return IconButton(
      onPressed: () {
        setState(() {
          _obscurePassword = !_obscurePassword;
        });
      },
      style: IconButton.styleFrom(
        minimumSize: const Size.square(32),
        padding: const EdgeInsets.all(4),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      icon: SvgPicture.asset(
        _obscurePassword
            ? 'assets/icons/visibility_off.svg'
            : 'assets/icons/visibility.svg',
        width: 24,
        height: 24,
        colorFilter: const ColorFilter.mode(
          AppColors.darkGray,
          BlendMode.srcIn,
        ),
        semanticsLabel: _obscurePassword ? '비밀번호 표시' : '비밀번호 숨기기',
      ),
    );
  }
}
