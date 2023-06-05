using Localizer;
using Bon;
using System;
namespace LocalizerTest;

public class Program 
{
	public static void Main()
	{

		let str  = LocalizedText("msg.test");
		let str2 = LocalizedText("msg.test2");

		Console.WriteLine(str);
		Console.WriteLine(str2);

		Localizer.LoadLanguage("fr.lang");
		Localizer.LoadLanguage("en.lang");

		Console.WriteLine(str);
		Console.WriteLine(str2);

		Localizer.SetLanguage("en_US");

		Console.WriteLine(str);
		Console.WriteLine(str2);

		Localizer.RemoveLanguage("en_US");

		Console.WriteLine(str);
		Console.WriteLine(str2);

		Console.Read();

	}
}