---
layout: post
title: "Promises"
categories: blog
---

<img src="/images/promises/pinky.png"
     title="https://www.flickr.com/photos/ditatompel/4650762539/in/photolist-85YnF2-jgsaZi-8Gz9Zp-mgFCQQ-k9T5EU-jAyT6D-dSNHrp-5cxjZ-MAwyf-qr9F4f-a1eLNm-b6Wy1i-oF5J28-8Hnv8U-qr9DuU-8QogK7-4nXTrf-8543iX-5krye5-axjLJD-6uAR6m-D3mW5b-61M2po-au5fmY-8iUvbU-7FAHEc-cADEjb-8jeyRC-7pPPxV-68Gdtt-oFiRwd-8ZCSaF-rX74SB-rX73XR-8ZCSr6-rh9hSC-heQh73-epTFrK-8pLBTP-cVZd2u-o3msB5-77q7wn-3sBrkX-6XWnCz-bRY9b2-bU5kwn-4HFWCg-bU5hQZ-bU5iE2-6VC33r"
     class="fit image" />

The Promise app intends to reify promises (informal contracts) between parties,
establishing a notion of identity easily and _transferably_, and facilitating
tracking of communication and _intent_.

<!--more-->

## Service Architecture

<!--
cat <<EOF | digraph | OUTPUT=images/promises/dot_13440.png dotshow
    database;
    backend;
    client_service;
    verifying_client_service;
    translational_client;
    stateful_client;;
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

#### Stateful
#### Verifiable
#### External

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

## Backend Entitiles

| Table           | Links            | Details                                            |
| -------------   | -----            | --------------                                     |
| Users           |                  | Internal Promise Account Details                   |
| Provider        |                  | External Identity Providers (Slack, Linkdin, etc.) |
| Identity        | User -> Provider |                                                    |
| Promises        | User -> User     | Connection between Users, with details             |
| Acknowlegement  | User -> Promise  |                                                    |
| Fulfilment      | User -> Promise  |                                                    |

Any interactions should be tagged with both a user and an identity, this
makes an informal audit possible.


