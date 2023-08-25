String getAuthorityFromDeepLink(String deepLink) {
  int authorityFirstLetterIndex = deepLink.indexOf('Authority');
  int authorityLastLetterIndex = deepLink.indexOf('&');

  return deepLink.substring(
    authorityFirstLetterIndex + 10,
    authorityLastLetterIndex,
  );
}

String getStatusFromDeepLink(String deepLink) {
  int statusFirstLetterIndex = deepLink.indexOf('Status');

  return deepLink.substring(statusFirstLetterIndex + 7);
}
