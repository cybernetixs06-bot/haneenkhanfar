# My Prompts

All prompts from this conversation, in order, with spelling mistakes corrected.

---

## 1

Give me a class of model in Dart that has a required value of name, an int value for size, and a string for ticket id. The model is for a party in a restaurant.

---

## 2

These parties have to be stored in sqflite, so I want you to give me database code with a single object and put the props in the table as I mentioned to match the model.

---

## 3

Split the data source and the repo.

---

## 4

My model will not use the layer of local data source because the app is small, so I will use the repo directly to access the db.

---

## 5

Now I want to create the abstract class of the repo, and I will edit it to implement the abstract class.

---

## 6

Now I want to create the use cases. We have the abstract class and the impl.

---

## 7

I want to ask: the model is used in the data layer and the entity in the domain. In the repo I use the entity and in the repo impl I use the model. I want an example to use them.

---

## 8

Now I will use Riverpod. First I want to create the providers to inject all services, use cases, repo, and data source.

---

## 9

Match the names here in the providers.

```dart
import 'package:restorenttask_haneenkhanfar/modules/domain/party_entity.dart';
import 'package:restorenttask_haneenkhanfar/modules/domain/party_repo_abstract.dart';

class AddParty {
  const AddParty(this._repository);

  final PartyRepository _repository;

  Future<void> call(PartyEntity party) => _repository.addParty(party);
}
//..

class GetParties {
  const GetParties(this._repository);

  final PartyRepository _repository;

  Future<List<PartyEntity>> call() => _repository.getParties();
}
```

---

## 10

Rewrite the use cases that are not in the code above.

---

## 11

Now I want to create the viewmodel. The viewmodel must have an AsyncProvider to have the three states: loading, error, data. It must have a build function for the initial state, and it will use the use case to load the parties. Then I want the given functions to be in the viewmodel: add, remove, update, refresh, get one party. Use guard for the states.

---

## 12

Now I want to write the UI. You should use the ConsumerWidget class and watch the provider. In the screen we should have a SingleChildScrollView with the scrollable property, with cards for every party showing the name and size. Use the function `when` to handle the 3 states.

---

## 13

I want to create a ticket for every party based on the number of them, so I want you to write a function that makes a loop on the items and returns an int number of the parties. The loop must iterate on the db directly.

---

## 14

Add an onTap function to the card. When pressed, it opens a dialog, uses the function of getting the party, and puts the fields in text fields to edit. Add OK and Cancel buttons. The OK button will use the update function.

```dart
import 'package:flutter/material.dart';
import 'package:restorenttask_haneenkhanfar/modules/domain/party_entity.dart';

class PartyCard extends StatelessWidget {
  const PartyCard({super.key, required this.party});

  final PartyEntity party;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: const CircleAvatar(child: Icon(Icons.groups)),
        title: Text(party.name),
        subtitle: Text('Size: ${party.size}'),
      ),
    );
  }
}
```

---

## 15

Convert string to int.

```dart
        trailing: Text('ahead tickets: ${party.ticketId-1}'),

```

---

## 16

Give me a delete button that uses the viewmodel to delete the item.

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restorenttask_haneenkhanfar/modules/domain/party_entity.dart';
import 'package:restorenttask_haneenkhanfar/modules/presentation/party_cart_widget.dart';
import 'package:restorenttask_haneenkhanfar/modules/presentation/party_viewmode;.dart';

// Adjust this path to where your viewmodel file is

class PartiesScreen extends ConsumerWidget {
  const PartiesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final partiesAsync = ref.watch(partyViewModelProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Parties')),
      body: partiesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Something went wrong\n$error',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () =>
                      ref.read(partyViewModelProvider.notifier).refresh(),
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
        ),
        data: (parties) {
          if (parties.isEmpty) {
            return const Center(child: Text('No parties yet'));
          }

          return RefreshIndicator(
            onRefresh: () =>
                ref.read(partyViewModelProvider.notifier).refresh(),
            child: SingleChildScrollView(
              // Needed so pull-to-refresh works even with few items
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  for (final party in parties) PartyCard(party: party),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}


```

---

## 17

Add the update method here.

```dart
 if (formKey.currentState!.validate()) {
                 
                }\
```

---

## 18

Create a file that contains all my prompts for you, with every one numbered, with the .md extension.
