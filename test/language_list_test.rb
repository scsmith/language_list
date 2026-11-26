require 'minitest/autorun'
require 'language_list'

class LanguageListTest < Minitest::Test
  def test_all_languages
    assert_equal 7723, LanguageList::ALL_LANGUAGES.length
  end

  def test_common_languages
    assert_equal 234, LanguageList::COMMON_LANGUAGES.length
  end

  def test_living_languages
    assert_equal 7029, LanguageList::LIVING_LANGUAGES.length
  end

  def test_iso_iso_639_1_languages
    assert_equal 344, LanguageList::ISO_639_1.length
  end

  def test_common_languages_have_an_iso_639_1
    assert LanguageList::COMMON_LANGUAGES.all?(&:iso_639_1?)
  end

  def test_ascl_label_and_living_type_for_australian_languages
    noongar = LanguageList::LanguageInfo.find_by_iso_639_3('nys')
    assert_equal 'Noongar', noongar.name
    assert_equal 'nys', noongar.iso_639_1
    assert noongar.common?
    assert LanguageList::LanguageInfo.find_by_iso_639_3('wrh').living?
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
