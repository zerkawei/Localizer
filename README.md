# Localizer

A small library to help with text localization that uses [Bon](https://github.com/EinScott/bon) for serialization/deserialization.

## Language file format

```js
{
    tag = "en_US",
    strings = [
        "msg.test": "This is a test",
        "msg.test2": "This is a second test"
    ]
}
```
```js
{
    tag = "fr_FR",
    strings = [
        "msg.test": "Ceci est un test"
    ]
}
```

## Usage
```c#
Localizer.LoadLanguage("fr.lang"); // The first language to be loaded will be set as the current
Localizer.LoadLanguage("en.lang");

let str = LocalizedText("msg.test");
let str2 = LocalizedText("msg.test2");

Console.WriteLine(str); // => "Ceci est un test"

// Localizer will display the key if no string is present in the current language
Console.WriteLine(str2); // => "msg.test2"

Localizer.SetLanguage("en_US");

Console.WriteLine(str); // => "This is a test"
Console.WriteLine(str2); // => "This is a second test"
```