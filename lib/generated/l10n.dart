// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class AppLocalizations {
  AppLocalizations();

  static AppLocalizations? _current;

  static AppLocalizations get current {
    assert(_current != null,
        'No instance of AppLocalizations was loaded. Try to initialize the AppLocalizations delegate before accessing AppLocalizations.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<AppLocalizations> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = AppLocalizations();
      AppLocalizations._current = instance;

      return instance;
    });
  }

  static AppLocalizations of(BuildContext context) {
    final instance = AppLocalizations.maybeOf(context);
    assert(instance != null,
        'No instance of AppLocalizations present in the widget tree. Did you add AppLocalizations.delegate in localizationsDelegates?');
    return instance!;
  }

  static AppLocalizations? maybeOf(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  /// `Welcome to`
  String get welcomeTo {
    return Intl.message(
      'Welcome to',
      name: 'welcomeTo',
      desc: '',
      args: [],
    );
  }

  /// `Prospector`
  String get prospector {
    return Intl.message(
      'Prospector',
      name: 'prospector',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong. Please try again later.`
  String get serverError {
    return Intl.message(
      'Something went wrong. Please try again later.',
      name: 'serverError',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong. Please check your internet connection and try again later.`
  String get noConnectionMessage {
    return Intl.message(
      'Something went wrong. Please check your internet connection and try again later.',
      name: 'noConnectionMessage',
      desc: '',
      args: [],
    );
  }

  /// `Invalid email and password combination`
  String get invalidEmailAndPassword {
    return Intl.message(
      'Invalid email and password combination',
      name: 'invalidEmailAndPassword',
      desc: '',
      args: [],
    );
  }

  /// `Your account is not associated with this profile. Try the other sign in methods.`
  String get accountWithDifferentCredentials {
    return Intl.message(
      'Your account is not associated with this profile. Try the other sign in methods.',
      name: 'accountWithDifferentCredentials',
      desc: '',
      args: [],
    );
  }

  /// `We haven't found any account associated with this email address. Please confirm your email.`
  String get userNotFoundResetPassword {
    return Intl.message(
      'We haven\'t found any account associated with this email address. Please confirm your email.',
      name: 'userNotFoundResetPassword',
      desc: '',
      args: [],
    );
  }

  /// `This email address is already in use.`
  String get emailAlreadyInUse {
    return Intl.message(
      'This email address is already in use.',
      name: 'emailAlreadyInUse',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Invalid email`
  String get invalidEmail {
    return Intl.message(
      'Invalid email',
      name: 'invalidEmail',
      desc: '',
      args: [],
    );
  }

  /// `Enter a password`
  String get enterAPassword {
    return Intl.message(
      'Enter a password',
      name: 'enterAPassword',
      desc: '',
      args: [],
    );
  }

  /// `Sign in`
  String get signIn {
    return Intl.message(
      'Sign in',
      name: 'signIn',
      desc: '',
      args: [],
    );
  }

  /// `Forgot my password`
  String get forgotPassword {
    return Intl.message(
      'Forgot my password',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get register {
    return Intl.message(
      'Register',
      name: 'register',
      desc: '',
      args: [],
    );
  }

  /// `- or continue with -`
  String get orContinueWith {
    return Intl.message(
      '- or continue with -',
      name: 'orContinueWith',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Confirm password`
  String get confirmPassword {
    return Intl.message(
      'Confirm password',
      name: 'confirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Enter your name`
  String get enterYourName {
    return Intl.message(
      'Enter your name',
      name: 'enterYourName',
      desc: '',
      args: [],
    );
  }

  /// `Weak Password. \n It must be at least 8 characters long and contain: \n - 1 uppercase letter \n - 1 lowercase letter \n - 1 number`
  String get weakPassword {
    return Intl.message(
      'Weak Password. \n It must be at least 8 characters long and contain: \n - 1 uppercase letter \n - 1 lowercase letter \n - 1 number',
      name: 'weakPassword',
      desc: '',
      args: [],
    );
  }

  /// `Passwords don't match`
  String get passwordsDontMatch {
    return Intl.message(
      'Passwords don\'t match',
      name: 'passwordsDontMatch',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get registerButton {
    return Intl.message(
      'Register',
      name: 'registerButton',
      desc: '',
      args: [],
    );
  }

  /// `Reset password`
  String get resetPassword {
    return Intl.message(
      'Reset password',
      name: 'resetPassword',
      desc: '',
      args: [],
    );
  }

  /// `Enter the email address you used to create your Prospector account`
  String get resetPasswordDialogMessage {
    return Intl.message(
      'Enter the email address you used to create your Prospector account',
      name: 'resetPasswordDialogMessage',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Send`
  String get send {
    return Intl.message(
      'Send',
      name: 'send',
      desc: '',
      args: [],
    );
  }

  /// `We have sent you an email with the steps to reset your password. \nPlease check your email inbox`
  String get resetPasswordEmailSent {
    return Intl.message(
      'We have sent you an email with the steps to reset your password. \nPlease check your email inbox',
      name: 'resetPasswordEmailSent',
      desc: '',
      args: [],
    );
  }

  /// `Ok`
  String get ok {
    return Intl.message(
      'Ok',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `There's been an error initializing the app. Please check your internet connection and try again later.`
  String get appStateError {
    return Intl.message(
      'There\'s been an error initializing the app. Please check your internet connection and try again later.',
      name: 'appStateError',
      desc: '',
      args: [],
    );
  }

  /// `Try again`
  String get tryAgain {
    return Intl.message(
      'Try again',
      name: 'tryAgain',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `PREMIUM`
  String get premiumCap {
    return Intl.message(
      'PREMIUM',
      name: 'premiumCap',
      desc: '',
      args: [],
    );
  }

  /// `until`
  String get until {
    return Intl.message(
      'until',
      name: 'until',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Edit image`
  String get editImage {
    return Intl.message(
      'Edit image',
      name: 'editImage',
      desc: '',
      args: [],
    );
  }

  /// `Change email`
  String get changeEmail {
    return Intl.message(
      'Change email',
      name: 'changeEmail',
      desc: '',
      args: [],
    );
  }

  /// `Change password`
  String get changePassword {
    return Intl.message(
      'Change password',
      name: 'changePassword',
      desc: '',
      args: [],
    );
  }

  /// `Logged in with`
  String get loggedInWith {
    return Intl.message(
      'Logged in with',
      name: 'loggedInWith',
      desc: '',
      args: [],
    );
  }

  /// `Log out`
  String get logOut {
    return Intl.message(
      'Log out',
      name: 'logOut',
      desc: '',
      args: [],
    );
  }

  /// `Delete account`
  String get deleteAccount {
    return Intl.message(
      'Delete account',
      name: 'deleteAccount',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete your account?`
  String get areYouSureDeleteAccount {
    return Intl.message(
      'Are you sure you want to delete your account?',
      name: 'areYouSureDeleteAccount',
      desc: '',
      args: [],
    );
  }

  /// `This action cannot be undone.`
  String get thisAcctionCannotBeUndone {
    return Intl.message(
      'This action cannot be undone.',
      name: 'thisAcctionCannotBeUndone',
      desc: '',
      args: [],
    );
  }

  /// `Enter your password to confirm`
  String get enterYourPasswordToConfirm {
    return Intl.message(
      'Enter your password to confirm',
      name: 'enterYourPasswordToConfirm',
      desc: '',
      args: [],
    );
  }

  /// `Type the word`
  String get typeTheWord {
    return Intl.message(
      'Type the word',
      name: 'typeTheWord',
      desc: '',
      args: [],
    );
  }

  /// `DELETE`
  String get deleteCap {
    return Intl.message(
      'DELETE',
      name: 'deleteCap',
      desc: '',
      args: [],
    );
  }

  /// `to confirm.`
  String get toConfirm {
    return Intl.message(
      'to confirm.',
      name: 'toConfirm',
      desc: '',
      args: [],
    );
  }

  /// `You may have to authenticate with your social account again.`
  String get youMayHaveToRelogin {
    return Intl.message(
      'You may have to authenticate with your social account again.',
      name: 'youMayHaveToRelogin',
      desc: '',
      args: [],
    );
  }

  /// `Type here`
  String get typeHere {
    return Intl.message(
      'Type here',
      name: 'typeHere',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get continueString {
    return Intl.message(
      'Continue',
      name: 'continueString',
      desc: '',
      args: [],
    );
  }

  /// `Select image`
  String get selectImage {
    return Intl.message(
      'Select image',
      name: 'selectImage',
      desc: '',
      args: [],
    );
  }

  /// `Take photo`
  String get takePhoto {
    return Intl.message(
      'Take photo',
      name: 'takePhoto',
      desc: '',
      args: [],
    );
  }

  /// `Name must not be empty`
  String get nameMustNotBeEmpty {
    return Intl.message(
      'Name must not be empty',
      name: 'nameMustNotBeEmpty',
      desc: '',
      args: [],
    );
  }

  /// `New email`
  String get newEmail {
    return Intl.message(
      'New email',
      name: 'newEmail',
      desc: '',
      args: [],
    );
  }

  /// `Confirm new email`
  String get confirmNewEmail {
    return Intl.message(
      'Confirm new email',
      name: 'confirmNewEmail',
      desc: '',
      args: [],
    );
  }

  /// `Emails don't match`
  String get emailsDontMatch {
    return Intl.message(
      'Emails don\'t match',
      name: 'emailsDontMatch',
      desc: '',
      args: [],
    );
  }

  /// `Current email`
  String get currentEmail {
    return Intl.message(
      'Current email',
      name: 'currentEmail',
      desc: '',
      args: [],
    );
  }

  /// `Reauthenticate`
  String get reauthenticate {
    return Intl.message(
      'Reauthenticate',
      name: 'reauthenticate',
      desc: '',
      args: [],
    );
  }

  /// `You need to reauthenticate. Enter your password to continue.`
  String get reauthMessage {
    return Intl.message(
      'You need to reauthenticate. Enter your password to continue.',
      name: 'reauthMessage',
      desc: '',
      args: [],
    );
  }

  /// `Current password`
  String get currentPassword {
    return Intl.message(
      'Current password',
      name: 'currentPassword',
      desc: '',
      args: [],
    );
  }

  /// `New password`
  String get newPassword {
    return Intl.message(
      'New password',
      name: 'newPassword',
      desc: '',
      args: [],
    );
  }

  /// `Confirm new password`
  String get confirmNewPassword {
    return Intl.message(
      'Confirm new password',
      name: 'confirmNewPassword',
      desc: '',
      args: [],
    );
  }

  /// `Show passwords`
  String get showPasswords {
    return Intl.message(
      'Show passwords',
      name: 'showPasswords',
      desc: '',
      args: [],
    );
  }

  /// `Hide passwords`
  String get hidePasswords {
    return Intl.message(
      'Hide passwords',
      name: 'hidePasswords',
      desc: '',
      args: [],
    );
  }

  /// `Dark theme`
  String get darkTheme {
    return Intl.message(
      'Dark theme',
      name: 'darkTheme',
      desc: '',
      args: [],
    );
  }

  /// `Light theme`
  String get lightTheme {
    return Intl.message(
      'Light theme',
      name: 'lightTheme',
      desc: '',
      args: [],
    );
  }

  /// `Prospects`
  String get prospects {
    return Intl.message(
      'Prospects',
      name: 'prospects',
      desc: '',
      args: [],
    );
  }

  /// `Name (Required)`
  String get nameRequired {
    return Intl.message(
      'Name (Required)',
      name: 'nameRequired',
      desc: '',
      args: [],
    );
  }

  /// `Phone`
  String get phone {
    return Intl.message(
      'Phone',
      name: 'phone',
      desc: '',
      args: [],
    );
  }

  /// `New phone`
  String get newPhone {
    return Intl.message(
      'New phone',
      name: 'newPhone',
      desc: '',
      args: [],
    );
  }

  /// `City`
  String get city {
    return Intl.message(
      'City',
      name: 'city',
      desc: '',
      args: [],
    );
  }

  /// `New prospect`
  String get newProspect {
    return Intl.message(
      'New prospect',
      name: 'newProspect',
      desc: '',
      args: [],
    );
  }

  /// `Edit prospect`
  String get editProspect {
    return Intl.message(
      'Edit prospect',
      name: 'editProspect',
      desc: '',
      args: [],
    );
  }

  /// `Gender`
  String get gender {
    return Intl.message(
      'Gender',
      name: 'gender',
      desc: '',
      args: [],
    );
  }

  /// `Male`
  String get male {
    return Intl.message(
      'Male',
      name: 'male',
      desc: '',
      args: [],
    );
  }

  /// `Female`
  String get female {
    return Intl.message(
      'Female',
      name: 'female',
      desc: '',
      args: [],
    );
  }

  /// `Not interested`
  String get notInterested {
    return Intl.message(
      'Not interested',
      name: 'notInterested',
      desc: '',
      args: [],
    );
  }

  /// `Not interested`
  String get notInteresteF {
    return Intl.message(
      'Not interested',
      name: 'notInteresteF',
      desc: '',
      args: [],
    );
  }

  /// `Not interested`
  String get notInterestedP {
    return Intl.message(
      'Not interested',
      name: 'notInterestedP',
      desc: '',
      args: [],
    );
  }

  /// `Not contacted`
  String get notContacted {
    return Intl.message(
      'Not contacted',
      name: 'notContacted',
      desc: '',
      args: [],
    );
  }

  /// `Not contacted`
  String get notContactedF {
    return Intl.message(
      'Not contacted',
      name: 'notContactedF',
      desc: '',
      args: [],
    );
  }

  /// `Not contacted`
  String get notContactedP {
    return Intl.message(
      'Not contacted',
      name: 'notContactedP',
      desc: '',
      args: [],
    );
  }

  /// `Invited`
  String get invited {
    return Intl.message(
      'Invited',
      name: 'invited',
      desc: '',
      args: [],
    );
  }

  /// `Invited`
  String get invitedF {
    return Intl.message(
      'Invited',
      name: 'invitedF',
      desc: '',
      args: [],
    );
  }

  /// `Invited`
  String get invitedP {
    return Intl.message(
      'Invited',
      name: 'invitedP',
      desc: '',
      args: [],
    );
  }

  /// `Follow up`
  String get followUp {
    return Intl.message(
      'Follow up',
      name: 'followUp',
      desc: '',
      args: [],
    );
  }

  /// `Client`
  String get client {
    return Intl.message(
      'Client',
      name: 'client',
      desc: '',
      args: [],
    );
  }

  /// `Client`
  String get clientF {
    return Intl.message(
      'Client',
      name: 'clientF',
      desc: '',
      args: [],
    );
  }

  /// `Clients`
  String get clients {
    return Intl.message(
      'Clients',
      name: 'clients',
      desc: '',
      args: [],
    );
  }

  /// `Executive`
  String get executive {
    return Intl.message(
      'Executive',
      name: 'executive',
      desc: '',
      args: [],
    );
  }

  /// `Executive`
  String get executiveF {
    return Intl.message(
      'Executive',
      name: 'executiveF',
      desc: '',
      args: [],
    );
  }

  /// `Executives`
  String get executives {
    return Intl.message(
      'Executives',
      name: 'executives',
      desc: '',
      args: [],
    );
  }

  /// `Add tag`
  String get addTag {
    return Intl.message(
      'Add tag',
      name: 'addTag',
      desc: '',
      args: [],
    );
  }

  /// `Add a new tag:`
  String get addANewTag {
    return Intl.message(
      'Add a new tag:',
      name: 'addANewTag',
      desc: '',
      args: [],
    );
  }

  /// `Tag name`
  String get tagName {
    return Intl.message(
      'Tag name',
      name: 'tagName',
      desc: '',
      args: [],
    );
  }

  /// `Contact saved successfully`
  String get prospectSavedSuccessfully {
    return Intl.message(
      'Contact saved successfully',
      name: 'prospectSavedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Delete prospect`
  String get deleteProspect {
    return Intl.message(
      'Delete prospect',
      name: 'deleteProspect',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this Prospect?`
  String get areYouSureDeleteProspect {
    return Intl.message(
      'Are you sure you want to delete this Prospect?',
      name: 'areYouSureDeleteProspect',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message(
      'Edit',
      name: 'edit',
      desc: '',
      args: [],
    );
  }

  /// `Prospect Details`
  String get prospectDetails {
    return Intl.message(
      'Prospect Details',
      name: 'prospectDetails',
      desc: '',
      args: [],
    );
  }

  /// `Invite`
  String get invite {
    return Intl.message(
      'Invite',
      name: 'invite',
      desc: '',
      args: [],
    );
  }

  /// `Present`
  String get present {
    return Intl.message(
      'Present',
      name: 'present',
      desc: '',
      args: [],
    );
  }

  /// `Affiliate`
  String get affiliate {
    return Intl.message(
      'Affiliate',
      name: 'affiliate',
      desc: '',
      args: [],
    );
  }

  /// `Type an interaction...`
  String get typeAnInteraction {
    return Intl.message(
      'Type an interaction...',
      name: 'typeAnInteraction',
      desc: '',
      args: [],
    );
  }

  /// `General`
  String get general {
    return Intl.message(
      'General',
      name: 'general',
      desc: '',
      args: [],
    );
  }

  /// `Affiliated`
  String get affiliatedP {
    return Intl.message(
      'Affiliated',
      name: 'affiliatedP',
      desc: '',
      args: [],
    );
  }

  /// `You have no prospects yet on this list.\nTry adding a new prospect or moving one from the other lists.`
  String get noProspectsMessage {
    return Intl.message(
      'You have no prospects yet on this list.\nTry adding a new prospect or moving one from the other lists.',
      name: 'noProspectsMessage',
      desc: '',
      args: [],
    );
  }

  /// `There are no prospects matching the applied filters in this list`
  String get noFilteredProspectsMessage {
    return Intl.message(
      'There are no prospects matching the applied filters in this list',
      name: 'noFilteredProspectsMessage',
      desc: '',
      args: [],
    );
  }

  /// `There are no prospects matching your search.`
  String get noSearchProspectsMessage {
    return Intl.message(
      'There are no prospects matching your search.',
      name: 'noSearchProspectsMessage',
      desc: '',
      args: [],
    );
  }

  /// `Filter by...`
  String get filterBy {
    return Intl.message(
      'Filter by...',
      name: 'filterBy',
      desc: '',
      args: [],
    );
  }

  /// `Clear filters`
  String get clearFilters {
    return Intl.message(
      'Clear filters',
      name: 'clearFilters',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Membership`
  String get membership {
    return Intl.message(
      'Membership',
      name: 'membership',
      desc: '',
      args: [],
    );
  }

  /// `Import contacts`
  String get importContacts {
    return Intl.message(
      'Import contacts',
      name: 'importContacts',
      desc: '',
      args: [],
    );
  }

  /// `Events`
  String get events {
    return Intl.message(
      'Events',
      name: 'events',
      desc: '',
      args: [],
    );
  }

  /// `Tags`
  String get tags {
    return Intl.message(
      'Tags',
      name: 'tags',
      desc: '',
      args: [],
    );
  }

  /// `Whatsapp`
  String get whatsapp {
    return Intl.message(
      'Whatsapp',
      name: 'whatsapp',
      desc: '',
      args: [],
    );
  }

  /// `Imported contacts`
  String get importedContacts {
    return Intl.message(
      'Imported contacts',
      name: 'importedContacts',
      desc: '',
      args: [],
    );
  }

  /// `You haven't imported any contact yet. Try importing some of your device contacts.\n\nBe Sure to allow contacts access.`
  String get noImportedContactsMessage {
    return Intl.message(
      'You haven\'t imported any contact yet. Try importing some of your device contacts.\n\nBe Sure to allow contacts access.',
      name: 'noImportedContactsMessage',
      desc: '',
      args: [],
    );
  }

  /// `Import`
  String get import {
    return Intl.message(
      'Import',
      name: 'import',
      desc: '',
      args: [],
    );
  }

  /// `Loading contacts...`
  String get loadingContacts {
    return Intl.message(
      'Loading contacts...',
      name: 'loadingContacts',
      desc: '',
      args: [],
    );
  }

  /// `Select all`
  String get selectAll {
    return Intl.message(
      'Select all',
      name: 'selectAll',
      desc: '',
      args: [],
    );
  }

  /// `Unselect all`
  String get unselectAll {
    return Intl.message(
      'Unselect all',
      name: 'unselectAll',
      desc: '',
      args: [],
    );
  }

  /// `There are no contacts in your device contacts list.`
  String get noDeviceContactsMessage {
    return Intl.message(
      'There are no contacts in your device contacts list.',
      name: 'noDeviceContactsMessage',
      desc: '',
      args: [],
    );
  }

  /// `Sync contacts`
  String get syncContacts {
    return Intl.message(
      'Sync contacts',
      name: 'syncContacts',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get close {
    return Intl.message(
      'Close',
      name: 'close',
      desc: '',
      args: [],
    );
  }

  /// `Premium feature`
  String get premiumFeature {
    return Intl.message(
      'Premium feature',
      name: 'premiumFeature',
      desc: '',
      args: [],
    );
  }

  /// `This is a premium feature.\nUpgrade to one of our premium subscriptions to access this feature and take your business to the next level.`
  String get premiumFeatureMessage {
    return Intl.message(
      'This is a premium feature.\nUpgrade to one of our premium subscriptions to access this feature and take your business to the next level.',
      name: 'premiumFeatureMessage',
      desc: '',
      args: [],
    );
  }

  /// `More info`
  String get moreInfo {
    return Intl.message(
      'More info',
      name: 'moreInfo',
      desc: '',
      args: [],
    );
  }

  /// `Go to Settings`
  String get goToSettings {
    return Intl.message(
      'Go to Settings',
      name: 'goToSettings',
      desc: '',
      args: [],
    );
  }

  /// `Contacts access`
  String get contactsAccess {
    return Intl.message(
      'Contacts access',
      name: 'contactsAccess',
      desc: '',
      args: [],
    );
  }

  /// `Contacts access is not allowed for Prospector MLM.`
  String get contactsAccessMessage {
    return Intl.message(
      'Contacts access is not allowed for Prospector MLM.',
      name: 'contactsAccessMessage',
      desc: '',
      args: [],
    );
  }

  /// `Please allow it on your device settings.`
  String get allowAccess {
    return Intl.message(
      'Please allow it on your device settings.',
      name: 'allowAccess',
      desc: '',
      args: [],
    );
  }

  /// `Enable`
  String get enable {
    return Intl.message(
      'Enable',
      name: 'enable',
      desc: '',
      args: [],
    );
  }

  /// `Disable`
  String get disable {
    return Intl.message(
      'Disable',
      name: 'disable',
      desc: '',
      args: [],
    );
  }

  /// `Prospector will automatically import the new contacts you add on your device.`
  String get prospectorWillImportContacts {
    return Intl.message(
      'Prospector will automatically import the new contacts you add on your device.',
      name: 'prospectorWillImportContacts',
      desc: '',
      args: [],
    );
  }

  /// `Prospector will stop automatically importing your device new contacts.`
  String get prospectorWillStopImporting {
    return Intl.message(
      'Prospector will stop automatically importing your device new contacts.',
      name: 'prospectorWillStopImporting',
      desc: '',
      args: [],
    );
  }

  /// `Statistics`
  String get statistics {
    return Intl.message(
      'Statistics',
      name: 'statistics',
      desc: '',
      args: [],
    );
  }

  /// `New`
  String get newString {
    return Intl.message(
      'New',
      name: 'newString',
      desc: '',
      args: [],
    );
  }

  /// `Affiliate as`
  String get affiliateAs {
    return Intl.message(
      'Affiliate as',
      name: 'affiliateAs',
      desc: '',
      args: [],
    );
  }

  /// `Get rid of ads`
  String get getRidOfAds {
    return Intl.message(
      'Get rid of ads',
      name: 'getRidOfAds',
      desc: '',
      args: [],
    );
  }

  /// `Watch a short video to get`
  String get watchAShortVideo {
    return Intl.message(
      'Watch a short video to get',
      name: 'watchAShortVideo',
      desc: '',
      args: [],
    );
  }

  /// `minutes`
  String get minutes {
    return Intl.message(
      'minutes',
      name: 'minutes',
      desc: '',
      args: [],
    );
  }

  /// `of Prospector with no Ads`
  String get ofProspectorWithNoAds {
    return Intl.message(
      'of Prospector with no Ads',
      name: 'ofProspectorWithNoAds',
      desc: '',
      args: [],
    );
  }

  /// `Moved to`
  String get movedToM {
    return Intl.message(
      'Moved to',
      name: 'movedToM',
      desc: '',
      args: [],
    );
  }

  /// `Moved to`
  String get movedToF {
    return Intl.message(
      'Moved to',
      name: 'movedToF',
      desc: '',
      args: [],
    );
  }

  /// `Select a number`
  String get selectANumber {
    return Intl.message(
      'Select a number',
      name: 'selectANumber',
      desc: '',
      args: [],
    );
  }

  /// `No phone numbers`
  String get noPhonesTitle {
    return Intl.message(
      'No phone numbers',
      name: 'noPhonesTitle',
      desc: '',
      args: [],
    );
  }

  /// `This prospect has no phone numbers registered, add some to proceed.`
  String get noPhonesMessage {
    return Intl.message(
      'This prospect has no phone numbers registered, add some to proceed.',
      name: 'noPhonesMessage',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'es'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<AppLocalizations> load(Locale locale) => AppLocalizations.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
