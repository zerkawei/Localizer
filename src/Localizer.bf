using System;
using System.Collections;
namespace Localizer;

public static class Localizer
{
	public static Language Current;
}

public class Language
{
	public String Tag;
	public Dictionary<String,String> Strings;

	public this(String tag)
	{
		Tag     = tag;
		Strings = new .();
	}

	public ~this()
	{
		if(!Tag.HasExternalPtr) delete Tag;

		for(let (key, value) in Strings)
		{
			if(!key.HasExternalPtr)   delete key;
			if(!value.HasExternalPtr) delete value;
		}
		delete Strings;
	}
}

public struct LocalizedText : IDisposable, IFormattable
{
	public String Key;
	public String String => Localize!(Key);

	public this(String key) { Key = key; }
	public void Dispose()   { if(!Key.HasExternalPtr) delete Key; }

	public override void ToString(String strBuffer) => ToString(strBuffer, null, null);
	public void ToString(String outString, String format, IFormatProvider formatProvider)
	{
		let effectiveKey = scope String(Key);
		if(format != null && format.Length > 0) { effectiveKey..Append('.').Append(format); }	
		outString.Append(Localize!(effectiveKey));
	}

	private mixin Localize(String key)
	{
		(Localizer.Current == null) ? key : (Localizer.Current.Strings.GetValueOrDefault(key) ?? key)
	}
}