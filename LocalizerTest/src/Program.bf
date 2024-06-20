using System;
namespace Localizer
{
	using System.Collections;
	public extension Localizer
	{
		private static Dictionary<String, Language> languages = new .() ~ DeleteDictionaryAndValues!(_);

		public static void AddLanguage(Language lang) => languages.Add(lang.Tag, lang);
		public static bool RemoveLanguage(String tag)
		{
			if(Current?.Tag == tag) { Current = null; }
			
			if(languages.GetAndRemove(tag) case .Ok(let val))
			{
				delete val.value;
				return true;
			}
			return false;
		}
		public static void SetLanguage(String tag) => Current = languages.GetValueOrDefault(tag);
	}	
}

using Localizer;
namespace LocalizerTest;

public class Program 
{
	public static void Main()
	{
		let en = new Language("en_US");
		en.Strings.Add("msg.test", "This is a test");
		en.Strings.Add("msg.test2", "This is a second test");

		let fr = new Language("fr_FR");
		fr.Strings.Add("msg.test", "Ceci est un test");

		Localizer.AddLanguage(fr);
		Localizer.AddLanguage(en);


		let str  = LocalizedText("msg.test");
		let str2 = LocalizedText("msg.test2");

		Localizer.SetLanguage("fr_FR");

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