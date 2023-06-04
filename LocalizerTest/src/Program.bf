using Localizer;
using Bon;
using System;
namespace LocalizerTest;

public class Program 
{
	public static void Main()
	{
/*
		gBonEnv.serializeFlags |= .Verbose;

		let l = scope Language("fr_FR");
		l.Strings.Add("msg.test", "Ceci est un test");
		Bon.SerializeIntoFile(l, "fr.lang");

		let l2 = scope Language("en_US");
		l2.Strings.Add("msg.test", "This is a test");
		Bon.SerializeIntoFile(l2, "en.lang");
*/
		let str  = LocalizedText("msg.test");
		let str2 = LocalizedText("msg.test2");

		Console.WriteLine(str.String);
		Console.WriteLine(str2.String);

		Localizer.LoadLanguage("fr.lang");
		Localizer.LoadLanguage("en.lang");

		Console.WriteLine(str.String);
		Console.WriteLine(str2.String);

		Localizer.SetLanguage("en_US");

		Console.WriteLine(str.String);
		Console.WriteLine(str2.String);

		Console.Read();

	}
}