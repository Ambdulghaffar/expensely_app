# Auth Feature Plan

Work order for the authentication feature, from UI design through real
backend wiring.

- [x] Design: reusable widgets (AuthTextField, AuthButton, GoogleSignInButton, AuthDivider, AuthFooterLink, OnboardingSlide, AuthScreenScaffold)
- [x] Design: onboarding screen (3 slides)
- [x] Design: login screen
- [x] Design: register screen
- [x] Design: forgot password screen
- [x] Design: reset password screen
- [ ] Backend: add password field + Spring Security + JWT to expensely-api
- [ ] Backend: Google OAuth2 endpoint
- [ ] Backend: forgot/reset password flow (email)
- [ ] Flutter: wire real API calls (register, login, forgot/reset password)
- [ ] Flutter: Google Sign-In real integration
- [ ] Flutter: JWT storage (flutter_secure_storage) + auto-attach to Dio requests
- [ ] Flutter: route guard (redirect unauthenticated users to /login)
