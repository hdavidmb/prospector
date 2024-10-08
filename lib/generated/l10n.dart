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

  /// `Country code`
  String get countryCode {
    return Intl.message(
      'Country code',
      name: 'countryCode',
      desc: '',
      args: [],
    );
  }

  /// `Select your country code`
  String get selectYourCountryCode {
    return Intl.message(
      'Select your country code',
      name: 'selectYourCountryCode',
      desc: '',
      args: [],
    );
  }

  /// `This code will be used as default for your local contacts. For your international contacts please be sure to add the '+' symbol and their country code. Otherwise Whatsapp won't be able to identify your contact properly.`
  String get defaultCountryCodeMessage {
    return Intl.message(
      'This code will be used as default for your local contacts. For your international contacts please be sure to add the \'+\' symbol and their country code. Otherwise Whatsapp won\'t be able to identify your contact properly.',
      name: 'defaultCountryCodeMessage',
      desc: '',
      args: [],
    );
  }

  /// `You can modify your country code on Settings.`
  String get modifyCountryCodeMessage {
    return Intl.message(
      'You can modify your country code on Settings.',
      name: 'modifyCountryCodeMessage',
      desc: '',
      args: [],
    );
  }

  /// `Year`
  String get year {
    return Intl.message(
      'Year',
      name: 'year',
      desc: '',
      args: [],
    );
  }

  /// `Month`
  String get month {
    return Intl.message(
      'Month',
      name: 'month',
      desc: '',
      args: [],
    );
  }

  /// `Week`
  String get week {
    return Intl.message(
      'Week',
      name: 'week',
      desc: '',
      args: [],
    );
  }

  /// `Events settings`
  String get eventsSettings {
    return Intl.message(
      'Events settings',
      name: 'eventsSettings',
      desc: '',
      args: [],
    );
  }

  /// `Week starts on`
  String get weekStartsOn {
    return Intl.message(
      'Week starts on',
      name: 'weekStartsOn',
      desc: '',
      args: [],
    );
  }

  /// `Time format`
  String get timeFormat {
    return Intl.message(
      'Time format',
      name: 'timeFormat',
      desc: '',
      args: [],
    );
  }

  /// `hours`
  String get hours {
    return Intl.message(
      'hours',
      name: 'hours',
      desc: '',
      args: [],
    );
  }

  /// `All day`
  String get allDay {
    return Intl.message(
      'All day',
      name: 'allDay',
      desc: '',
      args: [],
    );
  }

  /// `Starts at`
  String get startsAt {
    return Intl.message(
      'Starts at',
      name: 'startsAt',
      desc: '',
      args: [],
    );
  }

  /// `Ends at`
  String get endsAt {
    return Intl.message(
      'Ends at',
      name: 'endsAt',
      desc: '',
      args: [],
    );
  }

  /// `Event details`
  String get eventDetails {
    return Intl.message(
      'Event details',
      name: 'eventDetails',
      desc: '',
      args: [],
    );
  }

  /// `Guests`
  String get guests {
    return Intl.message(
      'Guests',
      name: 'guests',
      desc: '',
      args: [],
    );
  }

  /// `Select guests`
  String get selectGuests {
    return Intl.message(
      'Select guests',
      name: 'selectGuests',
      desc: '',
      args: [],
    );
  }

  /// `Alert`
  String get alert {
    return Intl.message(
      'Alert',
      name: 'alert',
      desc: '',
      args: [],
    );
  }

  /// `None`
  String get none {
    return Intl.message(
      'None',
      name: 'none',
      desc: '',
      args: [],
    );
  }

  /// `At event time`
  String get atEventTime {
    return Intl.message(
      'At event time',
      name: 'atEventTime',
      desc: '',
      args: [],
    );
  }

  /// `minutes before`
  String get minutesBefore {
    return Intl.message(
      'minutes before',
      name: 'minutesBefore',
      desc: '',
      args: [],
    );
  }

  /// `hour before`
  String get hourBefore {
    return Intl.message(
      'hour before',
      name: 'hourBefore',
      desc: '',
      args: [],
    );
  }

  /// `hours before`
  String get hoursBefore {
    return Intl.message(
      'hours before',
      name: 'hoursBefore',
      desc: '',
      args: [],
    );
  }

  /// `day before`
  String get dayBefore {
    return Intl.message(
      'day before',
      name: 'dayBefore',
      desc: '',
      args: [],
    );
  }

  /// `days before`
  String get daysBefore {
    return Intl.message(
      'days before',
      name: 'daysBefore',
      desc: '',
      args: [],
    );
  }

  /// `week before`
  String get weekBefore {
    return Intl.message(
      'week before',
      name: 'weekBefore',
      desc: '',
      args: [],
    );
  }

  /// `Select alert`
  String get selectAlert {
    return Intl.message(
      'Select alert',
      name: 'selectAlert',
      desc: '',
      args: [],
    );
  }

  /// `Edit event`
  String get editEvent {
    return Intl.message(
      'Edit event',
      name: 'editEvent',
      desc: '',
      args: [],
    );
  }

  /// `New event`
  String get newEvent {
    return Intl.message(
      'New event',
      name: 'newEvent',
      desc: '',
      args: [],
    );
  }

  /// `Event`
  String get event {
    return Intl.message(
      'Event',
      name: 'event',
      desc: '',
      args: [],
    );
  }

  /// `Reminder`
  String get reminder {
    return Intl.message(
      'Reminder',
      name: 'reminder',
      desc: '',
      args: [],
    );
  }

  /// `Title (Required)`
  String get titleRequired {
    return Intl.message(
      'Title (Required)',
      name: 'titleRequired',
      desc: '',
      args: [],
    );
  }

  /// `Title is required`
  String get titleIsRequired {
    return Intl.message(
      'Title is required',
      name: 'titleIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Location`
  String get location {
    return Intl.message(
      'Location',
      name: 'location',
      desc: '',
      args: [],
    );
  }

  /// `Type location`
  String get typeLocation {
    return Intl.message(
      'Type location',
      name: 'typeLocation',
      desc: '',
      args: [],
    );
  }

  /// `You can select a location from the list or tap 'Intro' in your keyboard to use what you typed as location`
  String get customPlacesMessage {
    return Intl.message(
      'You can select a location from the list or tap \'Intro\' in your keyboard to use what you typed as location',
      name: 'customPlacesMessage',
      desc: '',
      args: [],
    );
  }

  /// `Start`
  String get start {
    return Intl.message(
      'Start',
      name: 'start',
      desc: '',
      args: [],
    );
  }

  /// `End`
  String get end {
    return Intl.message(
      'End',
      name: 'end',
      desc: '',
      args: [],
    );
  }

  /// `When`
  String get when {
    return Intl.message(
      'When',
      name: 'when',
      desc: '',
      args: [],
    );
  }

  /// `Delete event`
  String get deleteEvent {
    return Intl.message(
      'Delete event',
      name: 'deleteEvent',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this Element?`
  String get areYouSureDeleteEvent {
    return Intl.message(
      'Are you sure you want to delete this Element?',
      name: 'areYouSureDeleteEvent',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get continueText {
    return Intl.message(
      'Continue',
      name: 'continueText',
      desc: '',
      args: [],
    );
  }

  /// `Restore membership`
  String get restoreMembership {
    return Intl.message(
      'Restore membership',
      name: 'restoreMembership',
      desc: '',
      args: [],
    );
  }

  /// `1 Month`
  String get oneMonth {
    return Intl.message(
      '1 Month',
      name: 'oneMonth',
      desc: '',
      args: [],
    );
  }

  /// `3 Months`
  String get threeMonths {
    return Intl.message(
      '3 Months',
      name: 'threeMonths',
      desc: '',
      args: [],
    );
  }

  /// `6 Months`
  String get sixMonths {
    return Intl.message(
      '6 Months',
      name: 'sixMonths',
      desc: '',
      args: [],
    );
  }

  /// `12 Months`
  String get twelveMonths {
    return Intl.message(
      '12 Months',
      name: 'twelveMonths',
      desc: '',
      args: [],
    );
  }

  /// `1 Year`
  String get oneYear {
    return Intl.message(
      '1 Year',
      name: 'oneYear',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get saveFinancial {
    return Intl.message(
      'Save',
      name: 'saveFinancial',
      desc: '',
      args: [],
    );
  }

  /// `Current`
  String get currentText {
    return Intl.message(
      'Current',
      name: 'currentText',
      desc: '',
      args: [],
    );
  }

  /// `You will be billed for the firs time on`
  String get firstBill {
    return Intl.message(
      'You will be billed for the firs time on',
      name: 'firstBill',
      desc: '',
      args: [],
    );
  }

  /// `Your membership will renew automatically every`
  String get renewAutomatically {
    return Intl.message(
      'Your membership will renew automatically every',
      name: 'renewAutomatically',
      desc: '',
      args: [],
    );
  }

  /// `Prices shown in`
  String get pricesShownIn {
    return Intl.message(
      'Prices shown in',
      name: 'pricesShownIn',
      desc: '',
      args: [],
    );
  }

  /// `Every membership includes a 7 days free trial`
  String get freeTrialMessage {
    return Intl.message(
      'Every membership includes a 7 days free trial',
      name: 'freeTrialMessage',
      desc: '',
      args: [],
    );
  }

  /// `Prospector Premium`
  String get prospectorPremium {
    return Intl.message(
      'Prospector Premium',
      name: 'prospectorPremium',
      desc: '',
      args: [],
    );
  }

  /// `Statistics Module`
  String get statisticsModule {
    return Intl.message(
      'Statistics Module',
      name: 'statisticsModule',
      desc: '',
      args: [],
    );
  }

  /// `Measure what matters`
  String get measureWhatMatters {
    return Intl.message(
      'Measure what matters',
      name: 'measureWhatMatters',
      desc: '',
      args: [],
    );
  }

  /// `Plan to improve`
  String get planToImprove {
    return Intl.message(
      'Plan to improve',
      name: 'planToImprove',
      desc: '',
      args: [],
    );
  }

  /// `Direct contact`
  String get directContact {
    return Intl.message(
      'Direct contact',
      name: 'directContact',
      desc: '',
      args: [],
    );
  }

  /// `Remove Ads`
  String get removeAds {
    return Intl.message(
      'Remove Ads',
      name: 'removeAds',
      desc: '',
      args: [],
    );
  }

  /// `Get full access to the statistics module with usefull charts and insigts about your activity as Networker`
  String get statisticsModuleMessage {
    return Intl.message(
      'Get full access to the statistics module with usefull charts and insigts about your activity as Networker',
      name: 'statisticsModuleMessage',
      desc: '',
      args: [],
    );
  }

  /// `Keep track of your actions and effectiveness on the business skills`
  String get measureWhatMattersMessage {
    return Intl.message(
      'Keep track of your actions and effectiveness on the business skills',
      name: 'measureWhatMattersMessage',
      desc: '',
      args: [],
    );
  }

  /// `Compare your performance every month and plan your strategy for the future`
  String get planToImproveMessage {
    return Intl.message(
      'Compare your performance every month and plan your strategy for the future',
      name: 'planToImproveMessage',
      desc: '',
      args: [],
    );
  }

  /// `Call or text your prospects directly from within Prospector, so you can contact them just when you need it`
  String get directContactMessage {
    return Intl.message(
      'Call or text your prospects directly from within Prospector, so you can contact them just when you need it',
      name: 'directContactMessage',
      desc: '',
      args: [],
    );
  }

  /// `Manage your business with Prospector completly free of ads`
  String get removeAdsMessage {
    return Intl.message(
      'Manage your business with Prospector completly free of ads',
      name: 'removeAdsMessage',
      desc: '',
      args: [],
    );
  }

  /// `Congrats`
  String get congrats {
    return Intl.message(
      'Congrats',
      name: 'congrats',
      desc: '',
      args: [],
    );
  }

  /// `You are now a Prospector Premium user and now you have unlimited access to a lot of usefull features Prospector has to grow your bussiness.\n\nThanks for trusting us to help you in your journey. Let's take your bussiness to the next level.`
  String get purchaseThankMessage {
    return Intl.message(
      'You are now a Prospector Premium user and now you have unlimited access to a lot of usefull features Prospector has to grow your bussiness.\n\nThanks for trusting us to help you in your journey. Let\'s take your bussiness to the next level.',
      name: 'purchaseThankMessage',
      desc: '',
      args: [],
    );
  }

  /// `Your new subscription will start when the current one ends`
  String get yourNewSubscriptionWillStart {
    return Intl.message(
      'Your new subscription will start when the current one ends',
      name: 'yourNewSubscriptionWillStart',
      desc: '',
      args: [],
    );
  }

  /// `Membership restored`
  String get membershipRestored {
    return Intl.message(
      'Membership restored',
      name: 'membershipRestored',
      desc: '',
      args: [],
    );
  }

  /// `Your membership has been restored successfully.`
  String get yourMembershipHasBeenRestored {
    return Intl.message(
      'Your membership has been restored successfully.',
      name: 'yourMembershipHasBeenRestored',
      desc: '',
      args: [],
    );
  }

  /// `We couldn't find any membership active to restore. Please check your subscription status in the`
  String get weCoulntFindMembership {
    return Intl.message(
      'We couldn\'t find any membership active to restore. Please check your subscription status in the',
      name: 'weCoulntFindMembership',
      desc: '',
      args: [],
    );
  }

  /// `App Store`
  String get appStore {
    return Intl.message(
      'App Store',
      name: 'appStore',
      desc: '',
      args: [],
    );
  }

  /// `Play Store`
  String get playStore {
    return Intl.message(
      'Play Store',
      name: 'playStore',
      desc: '',
      args: [],
    );
  }

  /// `Prospects per list`
  String get prospectsPerList {
    return Intl.message(
      'Prospects per list',
      name: 'prospectsPerList',
      desc: '',
      args: [],
    );
  }

  /// `Include 'Not Interested'`
  String get includeNotInterested {
    return Intl.message(
      'Include \'Not Interested\'',
      name: 'includeNotInterested',
      desc: '',
      args: [],
    );
  }

  /// `You haven't added any prospect yet`
  String get youHaveNoProspects {
    return Intl.message(
      'You haven\'t added any prospect yet',
      name: 'youHaveNoProspects',
      desc: '',
      args: [],
    );
  }

  /// `Total`
  String get total {
    return Intl.message(
      'Total',
      name: 'total',
      desc: '',
      args: [],
    );
  }

  /// `Month actions`
  String get monthActions {
    return Intl.message(
      'Month actions',
      name: 'monthActions',
      desc: '',
      args: [],
    );
  }

  /// `This`
  String get thisText {
    return Intl.message(
      'This',
      name: 'thisText',
      desc: '',
      args: [],
    );
  }

  /// `Last`
  String get last {
    return Intl.message(
      'Last',
      name: 'last',
      desc: '',
      args: [],
    );
  }

  /// `Lifetime`
  String get lifetime {
    return Intl.message(
      'Lifetime',
      name: 'lifetime',
      desc: '',
      args: [],
    );
  }

  /// `Historic`
  String get historic {
    return Intl.message(
      'Historic',
      name: 'historic',
      desc: '',
      args: [],
    );
  }

  /// `Extra actions`
  String get extraActions {
    return Intl.message(
      'Extra actions',
      name: 'extraActions',
      desc: '',
      args: [],
    );
  }

  /// `Add Prospect`
  String get addProspect {
    return Intl.message(
      'Add Prospect',
      name: 'addProspect',
      desc: '',
      args: [],
    );
  }

  /// `New Client`
  String get newClient {
    return Intl.message(
      'New Client',
      name: 'newClient',
      desc: '',
      args: [],
    );
  }

  /// `New Executive`
  String get newExecutive {
    return Intl.message(
      'New Executive',
      name: 'newExecutive',
      desc: '',
      args: [],
    );
  }

  /// `Reactivate`
  String get reactivate {
    return Intl.message(
      'Reactivate',
      name: 'reactivate',
      desc: '',
      args: [],
    );
  }

  /// `Client to Executive`
  String get clientToExecutive {
    return Intl.message(
      'Client to Executive',
      name: 'clientToExecutive',
      desc: '',
      args: [],
    );
  }

  /// `Executive to Client`
  String get executiveToClient {
    return Intl.message(
      'Executive to Client',
      name: 'executiveToClient',
      desc: '',
      args: [],
    );
  }

  /// `Turn Down`
  String get turnDown {
    return Intl.message(
      'Turn Down',
      name: 'turnDown',
      desc: '',
      args: [],
    );
  }

  /// `Effectiveness`
  String get effectiveness {
    return Intl.message(
      'Effectiveness',
      name: 'effectiveness',
      desc: '',
      args: [],
    );
  }

  /// `Out of`
  String get outOf {
    return Intl.message(
      'Out of',
      name: 'outOf',
      desc: '',
      args: [],
    );
  }

  /// `prospect added`
  String get prospectAdded {
    return Intl.message(
      'prospect added',
      name: 'prospectAdded',
      desc: '',
      args: [],
    );
  }

  /// `prospects added`
  String get prospectsAdded {
    return Intl.message(
      'prospects added',
      name: 'prospectsAdded',
      desc: '',
      args: [],
    );
  }

  /// `in the`
  String get inThe {
    return Intl.message(
      'in the',
      name: 'inThe',
      desc: '',
      args: [],
    );
  }

  /// `to`
  String get to {
    return Intl.message(
      'to',
      name: 'to',
      desc: '',
      args: [],
    );
  }

  /// `were moved to`
  String get wereMovedTo {
    return Intl.message(
      'were moved to',
      name: 'wereMovedTo',
      desc: '',
      args: [],
    );
  }

  /// `or`
  String get or {
    return Intl.message(
      'or',
      name: 'or',
      desc: '',
      args: [],
    );
  }

  /// `are still in`
  String get areStillIn {
    return Intl.message(
      'are still in',
      name: 'areStillIn',
      desc: '',
      args: [],
    );
  }

  /// `Deleted`
  String get deleted {
    return Intl.message(
      'Deleted',
      name: 'deleted',
      desc: '',
      args: [],
    );
  }

  /// `Deleted`
  String get deletedP {
    return Intl.message(
      'Deleted',
      name: 'deletedP',
      desc: '',
      args: [],
    );
  }

  /// `Turn down analysis`
  String get turnDownAnalysis {
    return Intl.message(
      'Turn down analysis',
      name: 'turnDownAnalysis',
      desc: '',
      args: [],
    );
  }

  /// `Which list do those who said no come from?`
  String get wichListCome {
    return Intl.message(
      'Which list do those who said no come from?',
      name: 'wichListCome',
      desc: '',
      args: [],
    );
  }

  /// `Total turn downs`
  String get totalTurnDowns {
    return Intl.message(
      'Total turn downs',
      name: 'totalTurnDowns',
      desc: '',
      args: [],
    );
  }

  /// `Came from`
  String get cameFrom {
    return Intl.message(
      'Came from',
      name: 'cameFrom',
      desc: '',
      args: [],
    );
  }

  /// `prospects_per_list_1_en.jpg`
  String get prospectsPerListImg1 {
    return Intl.message(
      'prospects_per_list_1_en.jpg',
      name: 'prospectsPerListImg1',
      desc: '',
      args: [],
    );
  }

  /// `prospects_per_list_2_en.jpg`
  String get prospectsPerListImg2 {
    return Intl.message(
      'prospects_per_list_2_en.jpg',
      name: 'prospectsPerListImg2',
      desc: '',
      args: [],
    );
  }

  /// `no_chart_1_en.jpg`
  String get turnDownImg1 {
    return Intl.message(
      'no_chart_1_en.jpg',
      name: 'turnDownImg1',
      desc: '',
      args: [],
    );
  }

  /// `effectiveness_1_en.jpg`
  String get effectivenessImg1 {
    return Intl.message(
      'effectiveness_1_en.jpg',
      name: 'effectivenessImg1',
      desc: '',
      args: [],
    );
  }

  /// `actions_1_en.jpg`
  String get actionsPerMotnhImg1 {
    return Intl.message(
      'actions_1_en.jpg',
      name: 'actionsPerMotnhImg1',
      desc: '',
      args: [],
    );
  }

  /// `actions_2_en.jpg`
  String get actionsPerMotnhImg2 {
    return Intl.message(
      'actions_2_en.jpg',
      name: 'actionsPerMotnhImg2',
      desc: '',
      args: [],
    );
  }

  /// `actions_3_en.jpg`
  String get actionsPerMotnhImg3 {
    return Intl.message(
      'actions_3_en.jpg',
      name: 'actionsPerMotnhImg3',
      desc: '',
      args: [],
    );
  }

  /// `In Prospector you can classify your prospects in 6 different categories, depending on wich step of the prospecting process they are:`
  String get inProspectorYouHave6Categories {
    return Intl.message(
      'In Prospector you can classify your prospects in 6 different categories, depending on wich step of the prospecting process they are:',
      name: 'inProspectorYouHave6Categories',
      desc: '',
      args: [],
    );
  }

  /// `This chart shows you a summary of your entire list and how many prospects you have in each category.`
  String get thisChartIsSummaryOfYourList {
    return Intl.message(
      'This chart shows you a summary of your entire list and how many prospects you have in each category.',
      name: 'thisChartIsSummaryOfYourList',
      desc: '',
      args: [],
    );
  }

  /// `You can turn on the 'Not Interested' switch to display that category in the chart.`
  String get youCanTurnOnNotInterested {
    return Intl.message(
      'You can turn on the \'Not Interested\' switch to display that category in the chart.',
      name: 'youCanTurnOnNotInterested',
      desc: '',
      args: [],
    );
  }

  /// `As you manage your list and move your prospects between categories, Prospector automatically records the following actions:`
  String get asYouManageYourList {
    return Intl.message(
      'As you manage your list and move your prospects between categories, Prospector automatically records the following actions:',
      name: 'asYouManageYourList',
      desc: '',
      args: [],
    );
  }

  /// `When you create a new prospect or import a phone contact.`
  String get whenYouCreateAProspect {
    return Intl.message(
      'When you create a new prospect or import a phone contact.',
      name: 'whenYouCreateAProspect',
      desc: '',
      args: [],
    );
  }

  /// `When you move a prospect from`
  String get whenYouMoveAProspectFrom {
    return Intl.message(
      'When you move a prospect from',
      name: 'whenYouMoveAProspectFrom',
      desc: '',
      args: [],
    );
  }

  /// `This chart shows you how many times you have done each action on the selected month.`
  String get thisChartShowsYourActions {
    return Intl.message(
      'This chart shows you how many times you have done each action on the selected month.',
      name: 'thisChartShowsYourActions',
      desc: '',
      args: [],
    );
  }

  /// `You can turn on the 'Extra Actions' switch to include the folloing actions in the chart:`
  String get youCanTurnOnExtraActions {
    return Intl.message(
      'You can turn on the \'Extra Actions\' switch to include the folloing actions in the chart:',
      name: 'youCanTurnOnExtraActions',
      desc: '',
      args: [],
    );
  }

  /// `any category`
  String get anyCategory {
    return Intl.message(
      'any category',
      name: 'anyCategory',
      desc: '',
      args: [],
    );
  }

  /// `When you delete a prospect from your list.`
  String get whenYouDeleteAProspect {
    return Intl.message(
      'When you delete a prospect from your list.',
      name: 'whenYouDeleteAProspect',
      desc: '',
      args: [],
    );
  }

  /// `If you turn on the 'Historic' switch the chart will show the actions made every month on the selected time range.`
  String get ifYouTurnOnHistoric {
    return Intl.message(
      'If you turn on the \'Historic\' switch the chart will show the actions made every month on the selected time range.',
      name: 'ifYouTurnOnHistoric',
      desc: '',
      args: [],
    );
  }

  /// `This chart measures the effectiveness of your abilities stepping your prospects forward in the prospecting process.`
  String get thisChartMeasuresEffectiveness {
    return Intl.message(
      'This chart measures the effectiveness of your abilities stepping your prospects forward in the prospecting process.',
      name: 'thisChartMeasuresEffectiveness',
      desc: '',
      args: [],
    );
  }

  /// `The left side of the chart shows the number of prospects who have moved forward in the prospecting process from the selected step. The middle section shows the number of prospects that are still in the selected step and the right side shows the number of prospects who said 'No' while staying in the selected step.`
  String get theLeftSideShowsForward {
    return Intl.message(
      'The left side of the chart shows the number of prospects who have moved forward in the prospecting process from the selected step. The middle section shows the number of prospects that are still in the selected step and the right side shows the number of prospects who said \'No\' while staying in the selected step.',
      name: 'theLeftSideShowsForward',
      desc: '',
      args: [],
    );
  }

  /// `The example image shows that during this month you have invited 12 prospects. The left side shows that you actually presented to 5 of them (42% of the total 12), so they where moved to 'Follow Up'. The middle secction shows that you haven't presented to 3 of them (25%), so they are still in the 'Invited' category. And finally, the right side shows that 4 of them have said 'No'.`
  String get theExampleImageShowsEffectiveness {
    return Intl.message(
      'The example image shows that during this month you have invited 12 prospects. The left side shows that you actually presented to 5 of them (42% of the total 12), so they where moved to \'Follow Up\'. The middle secction shows that you haven\'t presented to 3 of them (25%), so they are still in the \'Invited\' category. And finally, the right side shows that 4 of them have said \'No\'.',
      name: 'theExampleImageShowsEffectiveness',
      desc: '',
      args: [],
    );
  }

  /// `This chart shows you in wich category were your prospects when they said 'No' to your oportunity. That way you can analyze wich steps of your prospecting process is generating more turn downs than others.`
  String get thisChartShowsInWichCategory {
    return Intl.message(
      'This chart shows you in wich category were your prospects when they said \'No\' to your oportunity. That way you can analyze wich steps of your prospecting process is generating more turn downs than others.',
      name: 'thisChartShowsInWichCategory',
      desc: '',
      args: [],
    );
  }

  /// `The left side of the chart shows the total number of prospects who have said 'No' during the selected time range (Red bar). The right side show how many of them come from each category.`
  String get theLeftSideShowsTurnDown {
    return Intl.message(
      'The left side of the chart shows the total number of prospects who have said \'No\' during the selected time range (Red bar). The right side show how many of them come from each category.',
      name: 'theLeftSideShowsTurnDown',
      desc: '',
      args: [],
    );
  }

  /// `The example image shows that a total of 9 prospects have said 'No' in the selected time range, of which 1 came from 'Not Contacted', 3 came from 'Invited' and 5 came from 'Follow Up'.`
  String get theExampleImageShowsTurnDown {
    return Intl.message(
      'The example image shows that a total of 9 prospects have said \'No\' in the selected time range, of which 1 came from \'Not Contacted\', 3 came from \'Invited\' and 5 came from \'Follow Up\'.',
      name: 'theExampleImageShowsTurnDown',
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
