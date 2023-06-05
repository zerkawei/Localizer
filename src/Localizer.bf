using System;
using System.Collections;
using Bon;
using Bon.Integrated;

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

	public static Result<void> LoadLanguage(StringView path)
	{
		var lang = new Language();
		Try!(Bon.DeserializeFromFile(ref lang, path));
		languages.Add(lang.[Friend]tag, lang);
		if(current == null) current = lang;
		return .Ok;
	}

	public static void RemoveLanguage(String tag)
	{
		let lang = languages.GetValueOrDefault(tag);
		if(lang == current) current = null;
		languages.Remove(tag);
		if(lang != null) delete lang;
	}

	public static void SetLanguage(String tag)
	{
		current = languages.GetValueOrDefault(tag);
	}
}

[BonTarget]
public sealed class Language
{
	[BonInclude] private String                    tag  ~ delete _;
	[BonInclude] private Dictionary<String,String> strings ~ DeleteDictionaryAndKeysAndValues!(_);

	public StringView Tag { [Inline] get => .(tag); }

	internal this() {}
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

	public override void ToString(String strBuffer)
	{
		strBuffer.Clear();
		strBuffer.Append(String);
	}
}

public static
{
	public static void LocalizedTextSerialize(BonWriter writer, ValueView val, BonEnvironment env, SerializeValueState state)
	{
		let dbr = *(LocalizedText*)val.dataPtr;
		writer.String(dbr.Key);
	}

	public static Result<void> LocalizedTextDeserialize(BonReader reader, ValueView val, BonEnvironment env, DeserializeValueState state)
	{
		var str = (*(LocalizedText*)val.dataPtr).Key = new .();
		Deserialize.String!(reader, ref str, env);
		return .Ok;
	}
}