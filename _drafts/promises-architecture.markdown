---
layout: post
title: "Promises"
categories: blog
---

<img src="/images/promises/pinky.png"
     title="https://www.flickr.com/photos/ditatompel/4650762539/in/photolist-85YnF2-jgsaZi-8Gz9Zp-mgFCQQ-k9T5EU-jAyT6D-dSNHrp-5cxjZ-MAwyf-qr9F4f-a1eLNm-b6Wy1i-oF5J28-8Hnv8U-qr9DuU-8QogK7-4nXTrf-8543iX-5krye5-axjLJD-6uAR6m-D3mW5b-61M2po-au5fmY-8iUvbU-7FAHEc-cADEjb-8jeyRC-7pPPxV-68Gdtt-oFiRwd-8ZCSaF-rX74SB-rX73XR-8ZCSr6-rh9hSC-heQh73-epTFrK-8pLBTP-cVZd2u-o3msB5-77q7wn-3sBrkX-6XWnCz-bRY9b2-bU5kwn-4HFWCg-bU5hQZ-bU5iE2-6VC33r"
     class="fit image" />

Promises intends to reify promises (informal contracts) between parties,
establishing a notion of identity easily and _transferably_, and facilitating
tracking of communication and _intent_.

Flexible identity services and management should make integrating new services
and identities into the promises ecosystem both straight-forward, and painless.
This should be true not only for users, but also for third-party service providers.

<!--more-->

## Contents

* [Contents](#contents)
* [Daydreaming](#daydreaming)
* [Service Architecture](#service-architecture)
* [Backend Entities](#backend-entities)
* [Identity](#identity)
* [Hosting / Deployment](#hosting--deployment)
* [Roadmap](#roadmap)

## Daydreaming

What would this look like at its core, and how could this evolve in the future?

At the core, I see Promises being a platform for tracking the commitments that you
have made, and providing a way for these commitments to be confirmed by the
receiving party. This would be realized by direct action through one of the
translational client-service APIs, such as the web-application, the slack
"/promise" command, etc. Or alternatively, through one of the stateful, observational
APIs, such as a slack-bot, an SMS concierge style interactive agent, or
something event more advanced.

The interesting paths that Promises can evolve down in the future would nearly
all be characterized as third-party service integrations, even if they
are developed by the same people who make Promises.

These services could include

* Promotional Services
* Matchmaking
* Promise fulfilment prioritization
* Promise making suggestions
* Trustworthiness ratings
* Relationship analysis,
* Etc.

## Service Architecture

<!--
cat <<EOF | digraph | OUTPUT=images/promises/dot_13440.png dotshow
    database;
    backend;
    client_service;
    verifying_client_service;
    translational_client;
    stateful_client;
    privelaged_client;

    database                 -> backend;
    backend                  -> client_service;
    backend                  -> verifying_client_service;
    backend                  -> translational_client;
    client_service           -> verifying_client_service [style=dashed];
    client_service           -> stateful_client;
    verifying_client_service -> privelaged_client;
EOF
-->

![](/images/promises/dot_13440.png)

### Types of Client Services

There are a few factors that may be present in the various categories client services...

#### "Translational"

These exist mainly to pass information dircetly through to the backend-api,
they simply translate some simple information, such as removing client-specific
prefixes, translating user-identities, and so on.

Translational APIs have a property that their computational requirements should
scale perfectly linearly with the backend-api. Since this is the case, it makes
sense to integrate them into the backend service as a sub-application via
snaplets rather than running them as an external service.

An example of a client performing a largely translational role would be the
Sack "Forward-Slash" API.

#### "Stateful"

A stateful service maintains internal state that is useful for the service,
but not nececerily for the backend. This could be used for providing
bots with persistant connections, concierge style interactions with users,
large-scale machine-learning capabilities, whatever can be expressed
as a service-gateway specific concept that doesn't justify integration
into the back-end.

An example of a stateful service would be a Slack Bot, with two main kinds
of state:

* Connection State (Connection to the Slack Channel, etc.)
* Interaction State (Previous interactions with users, etc.)

#### "Verifiable"

Verifiable services provide a mechanism for users to initially perform
identity confirmation during sign-up, as well as for use during multi-factor
style authentication for other operations in the system.

The identity services are intended to provide an identity-provider network
that should allow users to associate new accounts, and drop unused or
untrusted accounts with ease.

An example of a verified service would be an Email Gateway.

#### "External"

External entities may wish to provide services that interact with the
promises backend. The architecture of the promise application should
be such that there should be no reason why third parties couldn't
use the backend in the same manner in which internal services do.

The backend-api is intended to be versioned and stable, so that intagration
can be dependable and well documented.

An example of an external client-service would be "Linkdin" if they decided
to integrate promises into their messaging platform.

<hr />

### Example - Slack (with email auth)

<!--
cat <<EOF | digraph | OUTPUT=images/promises/dot_13564.png dotshow
    postgres;
    backend_api;
    slack_api;
    email_api;
    slack;

    postgres       -> backend_api;
    backend_api    -> slack_api;
    backend_api    -> email_api;
    slack_api      -> slack;
EOF
-->

![](/images/promises/dot_13564.png)

### Interaction - User Connects Slack to their Existing Promises Account

     Email        Slack             Slack API         Email API        Backend
     |             |                    |                   |                |
     |             |/promise signup     |                   |                |
     |             |           \------->|                   |                |
     |             |            Account?|                   |                |
     |             |<-------------/     |                   |                |
     |             |a@b.com             |                   |                |
     |             |     \------------->|                   |                |
     |             |                    |verify a@slack,    |                |
     |             |                    |       a@b.com     |                |
     |             |                    |         \------------------------->|
     |             |                    |                   |    Confirm Link|
     |             |                    |                   |<-----/         |
     |             |                    |        Email Link |                |
     |<-------------------------------------------/         |                |
     |Click/Reply  |                    |                   |                |
     |   \------------------------------------------------->|                |
     |             |                    |                   |Cool Guy        |
     |             |                    |                   |      \-------->|
     |             |                    |                   |         Linked!|
     |             |                    |                   |     You're Cool|
     |             |<------------------------------------------------/       |
     |             |/promise @u $       |                   |                |
     |             |      \------------>|                   |                |
     |             |                    |   .............   |                |
     |             |                    |   User now acts   |                |
     |             |                    |  as authenticated |                |

## Backend Entities

| Table           | Links            | Details                                            |
| -------------   | -----            | --------------                                     |
| Users           |                  | Internal Promise Account Details                   |
| Provider        |                  | External Identity Providers (Slack, Linkdin, etc.) |
| Identity        | User -> Provider |                                                    |
| Promises        | User -> User     | Connection between Users, with details             |
| Acknowledgement | User -> Promise  |                                                    |
| Fulfilment      | User -> Promise  |                                                    |

Any interactions should be tagged with both a user and an identity, this
makes an informal audit possible.


## Identity

Rather than trying to describe the identity model from the get-go,
I'd first like to outline a few standard and interesting use-cases
involving identity in Promises, and from there, factor out the model.

I would like to be able to:

* Sign-in, and out through the promises web-app.
* Have 2nd factor auth verify who I am for important interactions with Promises
* Sign-in to promises via a connected service (such as slack)
* Disconnect services from my identity
* Retroactively retract non-verified promises
* Associate previously disassociated accounts and identities
* Promote non-verifying services to verifying services through a service trust network
* Make a promise to someone who does not yet have a promises account

## Hosting / Deployment

## Roadmap

Provide a set of check-points in terms of functionality.

### Checkpoint 1 - Hello World

Spin up snap with stack, run hello world web-application.

### Checkpoint 2 - Fake Slack-Slash API

Re-code the hello-world web-app to provide a /command API
that can be used by simple Slack /promise commands,
such as "make" and "list".

### Checkpoint 3 - AWS Elastic Beanstalk Hosting

Configure the application with Docker to allow simple hosting
on AWS Elastic Beanstalk. Perform a proof-of-concept deployment
and Configure Slack to use the hosted endpoint.

Test that a user-interaction through slack behaves as expected.
Once this has been tested the hosted application can be decomissioned
until further development has been completed.

### Checkpoint 4 - Backend Service

### Checkpoint 5 - Database

### Checkpoint 6 - Identity

### Checkpoint 7 - AWS Hosting Version 2

Hosted CI through [Shippable.](https://app.shippable.com/)

Run docker compose stack through [AWS ECS.](http://docs.aws.amazon.com/AmazonECS/latest/developerguide/Welcome.html)
