require 'minitest/autorun'
require 'language_list'

class LanguageListTest < Minitest::Test
  def test_all_languages
    assert_equal 7707, LanguageList::ALL_LANGUAGES.length
  end

  def test_common_languages
    assert_equal 71, LanguageList::COMMON_LANGUAGES.length
  end

  def test_living_languages
    assert_equal 6986, LanguageList::LIVING_LANGUAGES.length
  end

  def test_iso_iso_639_1_languages
    assert_equal 184, LanguageList::ISO_639_1.length
  end

  def test_find_by_iso_639_1
    english = LanguageList::LanguageInfo.find_by_iso_639_1('en')
    assert_equal 'en', english.iso_639_1
    assert_equal 'eng', english.iso_639_3
    assert_equal 'English', english.name
  end

  def test_find_by_iso_639_3
    english = LanguageList::LanguageInfo.find_by_iso_639_3('eng')
    assert_equal 'en', english.iso_639_1
    assert_equal 'eng', english.iso_639_3
    assert_equal 'English', english.name
  end

  def test_find_by_name
    english = LanguageList::LanguageInfo.find_by_name('English')
    assert_equal 'en', english.iso_639_1
    assert_equal 'eng', english.iso_639_3
    assert_equal 'English', english.name
  end

  def test_case_insensitive_find_by_name
    english = LanguageList::LanguageInfo.find_by_name('english')
    assert_equal 'en', english.iso_639_1
    assert_equal 'eng', english.iso_639_3
    assert_equal 'English', english.name
  end

  def test_find_with_iso_639_1_code
    english = LanguageList::LanguageInfo.find('en')
    assert_equal 'en', english.iso_639_1
    assert_equal 'eng', english.iso_639_3
    assert_equal 'English', english.name
  end

  def test_case_insensitive_find_with_iso_639_1_code
    english = LanguageList::LanguageInfo.find('EN')
    assert_equal 'en', english.iso_639_1
    assert_equal 'eng', english.iso_639_3
    assert_equal 'English', english.name
  end

  def test_find_with_iso_639_2b_code
    english = LanguageList::LanguageInfo.find('fre')
    assert_equal 'fr', english.iso_639_1
    assert_equal 'fre', english.iso_639_2b
    assert_equal 'fra', english.iso_639_3
    assert_equal 'French', english.name
  end

  def test_case_insensitive_find_with_iso_639_2b_code
    english = LanguageList::LanguageInfo.find('FRE')
    assert_equal 'fr', english.iso_639_1
    assert_equal 'fre', english.iso_639_2b
    assert_equal 'fra', english.iso_639_3
    assert_equal 'French', english.name
  end

  def test_find_with_iso_639_3_code
    english = LanguageList::LanguageInfo.find('eng')
    assert_equal 'en', english.iso_639_1
    assert_equal 'eng', english.iso_639_3
    assert_equal 'English', english.name
  end

  def test_case_insensitive_find_with_iso_639_3_code
    english = LanguageList::LanguageInfo.find('Eng')
    assert_equal 'en', english.iso_639_1
    assert_equal 'eng', english.iso_639_3
    assert_equal 'English', english.name
  end

  def test_find_with_name
    english = LanguageList::LanguageInfo.find('English')
    assert_equal 'en', english.iso_639_1
    assert_equal 'eng', english.iso_639_3
    assert_equal 'English', english.name
  end

  def test_sort_should_order_by_name
    sorted = LanguageList::COMMON_LANGUAGES.sort
    expected = LanguageList::COMMON_LANGUAGES.map(&:name).sort

    assert_equal expected, sorted.map(&:name)
  end

  def test_common_name_when_present
    greek = LanguageList::LanguageInfo.find('el')
    assert_equal 'Greek', greek.common_name
  end

  def test_common_name_when_not_present
    english = LanguageList::LanguageInfo.find('en')
    assert_equal english.name, english.common_name
  end
end
