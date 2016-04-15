require "test_helper"
require "html/pipeline/redcarpet_filter"
require "redcarpet"

class HTML::Pipeline::RedcarpetFilterTest < Minitest::Test
	RedcarpetFilter = HTML::Pipeline::RedcarpetFilter

  def setup
  end
  
  def test_that_it_has_a_version_number
    refute_nil ::HTML_Pipeline::RedcarpetFilter::VERSION
  end

  def test_html_works
    filter = RedcarpetFilter.new \
      %(Through <em>NO</em> <script>Double NO</script>)

    assert_equal %(<p>Through <em>NO</em> <script>Double NO</script></p>\n),
    filter.call
  end

  def test_filter_html_doesnt_break_two_space_hard_break
    filter = RedcarpetFilter.new \
      %(Lorem,  \nipsum\n)
    
    assert_equal %(<p>Lorem,<br>\nipsum</p>\n),
    filter.call
  end

  def test_headings_work
    filter = RedcarpetFilter.new \
      %(# H1\n## H2\n### H3\n#### H4\n##### H5\n###### H6)

    assert_equal %(<h1>H1</h1>\n\n<h2>H2</h2>\n\n<h3>H3</h3>\n\n<h4>H4</h4>\n\n<h5>H5</h5>\n\n<h6>H6</h6>\n),
    filter.call
  end

  def test_setext_headers_work
    filter = RedcarpetFilter.new \
      %(H1\n==\nH2\n--)

    assert_equal %(<h1>H1</h1>\n\n<h2>H2</h2>\n),
    filter.call
  end

  def test_bold_and_emphasis_work
    filter = RedcarpetFilter.new \
      %(*emphasis*, _emphasis_, un*frigging*believable, **strong**, __strong__)

    assert_equal %(<p><em>emphasis</em>, <em>emphasis</em>, un<em>frigging</em>believable, <strong>strong</strong>, <strong>strong</strong></p>\n),
    filter.call
  end

  def test_links_work
    filter = RedcarpetFilter.new \
      "[Daring Fireball's Markdown](https://daringfireball.net/projects/markdown/)"

    assert_equal %(<p><a href="https://daringfireball.net/projects/markdown/">Daring Fireball&#39;s Markdown</a></p>\n),
    filter.call
  end

  def test_automatic_web_link_works
    filter = RedcarpetFilter.new \
      "<https://daringfireball.net/projects/markdown/>"

    assert_equal %(<p><a href="https://daringfireball.net/projects/markdown/">https://daringfireball.net/projects/markdown/</a></p>\n),
    filter.call
  end

  def test_automatic_email_link_works
    filter = RedcarpetFilter.new \
      "<address@example.com>"

    assert_equal %(<p><a href="mailto:address@example.com">address@example.com</a></p>\n),
    filter.call
  end

  def test_reference_style_link_works
    filter = RedcarpetFilter.new \
      %(Markdown is from [Daring Fireball] [id].\n[id]: https://daringfireball.net/projects/markdown/ "Daring Fireball")

    assert_equal %(<p>Markdown is from <a href="https://daringfireball.net/projects/markdown/" title="Daring Fireball">Daring Fireball</a>.</p>\n),
    filter.call
  end

  def test_reference_style_link_with_implicit_name_shortcut_works
    filter = RedcarpetFilter.new \
      %(Markdown is from [Daring Fireball] [].\n[daring fireball]: https://daringfireball.net/projects/markdown/ "Daring Fireball")

    assert_equal %(<p>Markdown is from <a href="https://daringfireball.net/projects/markdown/" title="Daring Fireball">Daring Fireball</a>.</p>\n),
    filter.call
  end

  def test_code_works
    filter = RedcarpetFilter.new \
      "Use the `printf()` function"

    assert_equal "<p>Use the <code>printf()</code> function</p>\n",
    filter.call
  end

  def test_code_with_backticks_works
    filter = RedcarpetFilter.new \
      "A backtick-delimited string in a code span: `` `foo` ``"

    assert_equal "<p>A backtick-delimited string in a code span: <code>`foo`</code></p>\n",
    filter.call
  end

  def test_inline_images_work
    filter = RedcarpetFilter.new \
      %(![Alt text](/path/to/img.png "Optional title"))

    assert_equal %(<p><img src="/path/to/img.png" alt="Alt text" title="Optional title"></p>\n),
    filter.call
  end

  def test_reference_style_inline_images_work
    filter = RedcarpetFilter.new \
      %(![Alt text][id]\n[id]: /path/to/img.png "Optional title")

    assert_equal %(<p><img src="/path/to/img.png" alt="Alt text" title="Optional title"></p>\n),
    filter.call
  end

  def test_asterisk_backslash_escapes_work
    filter = RedcarpetFilter.new \
      %q(\*literal asterisks\*)

    assert_equal %(<p>*literal asterisks*</p>\n),
    filter.call
  end

  def test_backslash_backslash_escapes_work
    filter = RedcarpetFilter.new \
      %q(\\literal backslashes\\)

    assert_equal "<p>\\literal backslashes\\</p>\n",
    filter.call
  end

  def test_backtick_backslash_escapes_work
    filter = RedcarpetFilter.new \
      %q(\`literal backticks\`)

    assert_equal %(<p>`literal backticks`</p>\n),
    filter.call
  end

  def test_curly_brace_backslash_escapes_work
    filter = RedcarpetFilter.new \
      %q(\{literal curly braces\})

    assert_equal %(<p>{literal curly braces}</p>\n),
    filter.call
  end

  def test_dot_backslash_escape_works
    filter = RedcarpetFilter.new \
      %q(1\. literal dot)

    assert_equal %(<p>1. literal dot</p>\n),
    filter.call
  end

  def test_exclamation_point_backslash_escape_works
    filter = RedcarpetFilter.new \
      %q(\!\[literal exclamation mark\]\(path/to/img.png\))

    assert_equal %(<p>![literal exclamation mark](path/to/img.png)</p>\n),
    filter.call
  end

  def test_hyphen_backslash_escape_works
    filter = RedcarpetFilter.new \
      %q(\-literal hyphen)

    assert_equal %(<p>-literal hyphen</p>\n),
    filter.call
  end

  def test_octothorpe_backslash_escape_works
    filter = RedcarpetFilter.new \
      %q(\#literal octothorpe)

    assert_equal %(<p>#literal octothorpe</p>\n),
    filter.call
  end

  def test_parentheses_and_square_brackets_backslash_escapes_work
    filter = RedcarpetFilter.new \
      %q(\[foo\]\(literal parentheses\))

    assert_equal %(<p>[foo](literal parentheses)</p>\n),
    filter.call
  end

  def test_plus_backslash_escape_works
    filter = RedcarpetFilter.new \
      %q(\+literal plus)

    assert_equal %(<p>+literal plus</p>\n),
    filter.call
  end

  def test_underscore_backslash_escapes_work
    filter = RedcarpetFilter.new \
      %q(\_literal underscores\_)

    assert_equal %(<p>_literal underscores_</p>\n),
    filter.call
  end

  def test_horizontal_rules_work
    filter = RedcarpetFilter.new \
      %(* * *\n***\n*****\n- - -\n---)

    assert_equal %(<hr>\n\n<hr>\n\n<hr>\n\n<hr>\n\n<hr>\n),
    filter.call
  end

  def test_4_space_code_block_works
    filter = RedcarpetFilter.new \
      %(    foo)

    assert_equal %(<pre><code>foo\n</code></pre>\n),
    filter.call
  end

  def test_blockquotes_work
    filter = RedcarpetFilter.new \
      %(> This is a blockquote)

    assert_equal %(<blockquote>\n<p>This is a blockquote</p>\n</blockquote>\n),
    filter.call
  end

end
