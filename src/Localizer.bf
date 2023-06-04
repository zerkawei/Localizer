using System.Collections;
using System;
using Bon;
using internal Localizer;
namespace Localizer;

public static class Localizer
{
	private static Language current;
	private static Dictionary<String,Language> languages ~ DeleteDictionaryAndValues!(_);

	public static this()
	{
		languages = new .();
	}

	public static void LoadLanguage(StringView path)
	{
		var lang = new Language();
		Bon.DeserializeFromFile(ref lang, path);
		languages.Add(lang.Locale, lang);
		if(current == null)
		{
			current = lang;
		}
	}

	public static void SetLanguage(StringView locale)
	{
		current = languages.GetValueOrDefault(locale.ToString(.. scope .()));
	}
}

[BonTarget]
public sealed class Language
{
	[BonInclude] private String locale   ~ delete _;
	[BonInclude] private Dictionary<String,String> strings ~ DeleteDictionaryAndKeysAndValues!(_);

	public String Locale                      { get => locale; }
	public Dictionary<String, String> Strings { get => strings; }

	internal this() {}
	public this(String locale)
	{
		this.locale  = locale;
		this.strings = new .();
	}
}

[BonTarget]
public struct LocalizedText : IDisposable
{
	public String Key;
	public String String
	{
		get
		{
			if(Localizer.[Friend]current == null) return Key;

			let s = Localizer.[Friend]current.[Friend]strings.GetValueOrDefault(Key);
			return (s == default(String)) ? Key : s; 
		}
	}

	public this(String key) { Key = key; }
	public void Dispose() { if(!Key.HasExternalPtr) { delete Key; } }
}