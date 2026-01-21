# FlutterModelAssert

A lightweight, runtime API contract validator for Flutter that prevents silent backend changes from crashing your app due to unexpected type or structure mismatches.

---

## ❗ Problem it solves

Flutter apps rely on predefined Dart models to parse API responses.  
When backend teams update an API field type (e.g., `int → double`, `double → String`, `int → String`, or rename/remove keys), Flutter throws errors like:


This causes:
- App crashes at runtime
- API parsing failures
- Broken UI or infinite loading states
- Time-consuming debugging to find the exact mismatched field

FlutterModelAssert detects these issues **early and safely before parsing**, giving clear error reports so developers can fix instantly.

---

## ✨ Features

- Validates **required keys** in JSON responses
- Compares **backend response types vs expected Dart model types**
- Supports **nested JSON validation**
- Prevents **runtime crashes** by failing safely
- Provides **exact field mismatch reports**
- No code generation, no reflection (`dart:mirrors`) needed
- Ideal for **QA, staging, and debug builds**
- Works with `http`, `Dio`, or any JSON source

---

## 🚀 Installation

Add to `pubspec.yaml`:

```yaml
dependencies:
  flutter_model_assert: ^0.0.1


# FlutterModelAssert

A **build-time + runtime contract validator** that detects backend API type
regressions in Flutter **before your app crashes**.

---

## ❓ The Problem

You receive this error:

#usage

1️⃣ Annotate Your Model (ONE TIME)
import 'package:flutter_model_assert/flutter_model_assert.dart';

@ModelAssert()
class Order {
  int? status;
  Address? address;
  List<Items>? items;
}

2️⃣ Run Code Generation (ONE TIME)
flutter pub run build_runner build


3️⃣ Validate Backend Response (ONLY WHEN DEBUGGING)
final json = response.data as Map<String, dynamic>;

final result =
    FlutterModelAssert.validate<Order>(json);

if (!result.isValid) {
  debugPrint(result.prettyPrint());
  return null; // prevent crash
}

return Order.fromJson(json);


🧪 Sample Output
🚨 API Contract Broken

❗ status
   Expected: int?
   Received: String ("2")

❗ user.country.id
   Expected: int?
   Received: double (10.5)

❗ items[3].qty
   Expected: int?
   Received: String ("5")