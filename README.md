# Localizer

A small library to help with text localization.

## Basic Usage
```c#
let en = new Language("en_US");
en.Strings.Add("msg.test", "This is a test");
en.Strings.Add("msg.test2", "This is a second test");

let fr = new Language("fr_FR");
fr.Strings.Add("msg.test", "Ceci est un test");

let str = LocalizedText("msg.test");
let str2 = LocalizedText("msg.test2");

Localizer.Current = fr;
Console.WriteLine(str); // => "Ceci est un test"

// Localizer will display the key if no string is present in the current language
Console.WriteLine(str2); // => "msg.test2"

Localizer.Current = en;
Console.WriteLine(str); // => "This is a test"
Console.WriteLine(str2); // => "This is a second test"
```