<a name="ledger-sync--netsuite" />

# LedgerSync for NetSuite

[![Build Status](https://travis-ci.org/LedgerSync/ledger_sync-netsuite.svg?branch=master)](https://travis-ci.org/LedgerSync/ledger_sync-netsuite)
[![Gem Version](https://badge.fury.io/rb/ledger_sync-netsuite.svg)](https://badge.fury.io/rb/ledger_sync-netsuite)
[![Coverage Status](https://coveralls.io/repos/github/LedgerSync/ledger_sync-netsuite/badge.svg?branch=master)](https://coveralls.io/github/LedgerSync/ledger_sync-netsuite?branch=master)

<a name="ledger-sync--netsuite--join-the-conversation" />

# Join the Conversation

[Click here](https://join.slack.com/t/ledger-sync/shared_invite/zt-e5nbl8qc-eOA~5k7bg3p16_l3J7OS~Q) to join our public
Slack group.

<a name="architecture" />

---

# Architecture

This gem is built on top of the core [LedgerSync](https://github.com/LedgerSync/ledger_sync) gem. If you are unfamiliar
with the LedgerSync architecture, it is recommended to first read through
the [LedgerSync documentation](https://github.com/LedgerSync/ledger_sync).

---

<a name="getting-started" />

# Getting Started

<a name="getting-started--installation" />

## Installation

<a name="getting-started--installation--gemfile" />

### Gemfile

Add this line to your application’s Gemfile:

```
gem 'ledger_sync-netsuite'
```

And then execute:

```
bundle
```

<a name="getting-started--installation--directly" />

### Directly

Or install it yourself as:

```
gem install ledger_sync-netsuite
```

<a name="getting-started--authentication" />

## Authentication

For the REST API, NetSuite offers two types of authentication:

* Token Based Authentication (TBA)
* Oauth 2.0

This client currently uses TBA. While Oauth 2.0 may be available in the future, TBA was chosen for the following
reasons:

1. The SOAP API only supports TBA.
2. NetSuite users will still need to go through a manual setup (e.g. Integration record and Role) regardless of the
   method.

<a name="getting-started--authentication--token-based-authentication" />

### Token Based Authentication

In order to authenticate to NetSuite, you need the following:

* `account_id`
* `consumer_key`
* `consumer_secret`
* `token_id`
* `token_secret`

We will walk through how to get each value in the following sections.

> Note: You need to have sufficient permissions to set up your account for API authentication.

<a name="getting-started--authentication--token-based-authentication--prerequisites" />

#### Prerequisites

<a name="getting-started--authentication--token-based-authentication--prerequisites--rest-web-services-feature" />

##### REST Web Services feature

Enable the feature at Setup > Company > Setup Tasks > Enable Features, in the SuiteTalk (Web Services) section, on the
SuiteCloud subtab. To use the feature, you must accept the SuiteCloud Terms of Service.

<a name="getting-started--authentication--token-based-authentication--prerequisites--suite-analytics-workbook-feature" />

##### SuiteAnalytics Workbook feature

Enable the feature at Setup > Company > Setup Tasks > Enable Features, on the Analytics subtab.


<a name="getting-started--authentication--token-based-authentication--prerequisites--permissions" />

##### Permissions

You will require the following permissions:

* REST Web Services
* Log in using Access Tokens
* SuiteAnalytics Workbook

Your permissions vary based on which role you are assigned. You can edit roles in Setup > Users/Roles > User
Management > Manage Roles. Ensure your user is assigned a role with the aforementioned permissions in order to complete
the setup.

> Note:
> There are two different sets of permissions you will need:

* The permissions mentioned above are to set up your integration.
* Later when creating a token, you will need to assign a user with a role that has the necessary permissions to access
  records (e.g. payments, invoices, bills, etc.)

These can be the same or different roles. They can be assigned to one or many users.

##### Account ID

The `account_id` can be found in the URL when you are logged into the NetSuite dashboard in your browser. It will look
something like the following:

```http request
https://<account_id>.app.netsuite.com/app/center/card.nl?sc=-29&whence=
```

Example:

```http request
https://123456.app.netsuite.com/app/center/card.nl?sc=-29&whence=
```

The Account ID precedes `.app.netsuite.com`, which in this case is `123456`. Note that your ID may include `-sb1` (
representing “Sandbox 1”). Be sure to include the entire ID as it appears in the URL, including any letters, numbers,
and hyphens.

##### Consumer Keys

The consumer keys are retrieved when
you [create an Integration record](https://system.netsuite.com/app/help/helpcenter.nl?fid=bridgehead_4249032125.html&whence=)
. You can view
the [NetSuite documentation](https://system.netsuite.com/app/help/helpcenter.nl?fid=bridgehead_4249032125.html&whence=)
for the official documentation.

At the last step of creating an Integration record, save the consumer key and consumer secret. They will not be shown
again once you navigate away from the page.

##### Token

To obtain your `token_key` and `token_secret`, you will need
to [create a Token](https://system.netsuite.com/app/help/helpcenter.nl?fid=bridgehead_4254081947.html). View
the [NetSuite documentation](https://system.netsuite.com/app/help/helpcenter.nl?fid=bridgehead_4254081947.html) for the
official documentation.

You will use the integration record you created along with your user (or the user who has the necessary permissions to
access records).

At the last step, save the token key and token secret.

##### Conclusion

Now with these values, you can successfully authenticate to NetSuite. Simply pass the values into the client:

```ruby
client = LedgerSync::NetSuite::Client.new(
  account_id: account_id,
  consumer_key: consumer_key,
  consumer_secret: consumer_secret,
  token_id: token_id,
  token_secret: token_secret
)
```
---

<a name="resources" />

# Resources

To see all the available resources, you can call `LedgerSync::NetSuite::Client.resources`, which will give you a hash of keys and resource classes.

## Resource Attributes

To see all the available attributes of a resource you can call the `resource_attributes` class method.

## Resource Operations

To see all the available operations for a given resource you can call the `operations` class method. For example, you can call `LedgerSync::NetSuite::Customer.operations`, which will return a hash of keys mapped to operation classes.


## Resource Metadata and Schemas

Due to NetSuites granular user permissions and custom attributes, resources and methods for those resources can vary
from one user (a.k.a. token) to another. Because of this variance, there are some helper classes that allow you to
retrieve NetSuite records, allowed methods, attributes/parameters, etc.

To retrieve the metadata for a record:

```ruby
metadata = LedgerSync::NetSuite::Record::Metadata.new(
  client: netsuite_client, # Assuming this is previous defined
  record: :customer
)

puts metadata.http_methods # Returns a list of LedgerSync::Ledgers::NetSuite::Record::HTTPMethod objects
puts metadata.properties # Returns a list of LedgerSync::Ledgers::NetSuite::Record::Property objects

```
---

<a name="ledger-sync--quick-books-online--license" />

## License

This gem and all code contained in the repository is licensed under the same license as the core [LedgerSync](https://github.com/LedgerSync/ledger_sync) license. You can view all license details in the [LedgerSync](https://github.com/LedgerSync/ledger_sync) repo.