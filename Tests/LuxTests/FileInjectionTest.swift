//
//  File.swift
//  
//
//  Created by Alexis Bridoux on 01/05/2020.
//

import Foundation
import XCTest
import Lux

final class FileInjectionServiceTests: XCTestCase {

    let text =
    """
    <p>That’s it! So to insert a <code>Text</code> component which only appears when the user select the “Sushi” value, we would insert the following below the <code>ListInput</code> component we added previously:</p>

    <pre><code class="plist">&lt;dict&gt;
        &lt;key&gt;Type&lt;/key&gt;
        &lt;string&gt;Text&lt;/string&gt;
        &lt;key&gt;Text&lt;/key&gt;
        &lt;string&gt;So, do you like sushis?&lt;/string&gt;
        &lt;key&gt;Condition&lt;/key&gt;
        &lt;string&gt;FoodLike == "Sushis"&lt;/string&gt;
        &lt;key&gt;TextFontConfiguration&lt;/key&gt;
        &lt;string&gt;Body&lt;/string&gt;
    &lt;/dict&gt;</code></pre>
    <p>Now it’s time to add conditions!</p>
    <h3 id="addconditions">Add conditions</h3>
    <p>We will add three <code>Text</code> components: one for each possible meal. Each <code>Text</code> component will appear when the user selects a meal.</p>
    <p>In Octory, a condition is a <strong>String</strong> key which is most often named <strong>Condition</strong>. The value of this key is very similar to what you might use in Bash or another programming language. For example, to state that a component should only be visible when the variable <code>FoodLike</code> has the value “Sushis”, we would write</p>
    <pre><code>FoodLike == "Sushis"</code></pre>

    <p>That’s it! So to insert a <code>Text</code> component which only appears when the user select the “Sushi” value, we would insert the following below the <code>ListInput</code> component we added previously:</p>

    <pre><code class="plist">&lt;dict&gt;
        &lt;key&gt;Type&lt;/key&gt;
        &lt;string&gt;Text&lt;/string&gt;
        &lt;key&gt;Text&lt;/key&gt;
        &lt;string&gt;So, do you like sushis?&lt;/string&gt;
        &lt;key&gt;Condition&lt;/key&gt;
        &lt;string&gt;FoodLike == &quot;Sushis&quot;&lt;/string&gt;
        &lt;key&gt;TextFontConfiguration&lt;/key&gt;
        &lt;string&gt;Body&lt;/string&gt;
    &lt;/dict&gt;

    &lt;dict&gt;
        &lt;key&gt;Type&lt;/key&gt;
        &lt;string&gt;Text&lt;/string&gt;
        &lt;key&gt;Text&lt;/key&gt;
        &lt;string&gt;We all love pasta&lt;/string&gt;
        &lt;key&gt;Condition&lt;/key&gt;
        &lt;string&gt;FoodLike == &quot;Pasta&quot;&lt;/string&gt;
        &lt;key&gt;TextFontConfiguration&lt;/key&gt;
        &lt;string&gt;Body&lt;/string&gt;
    &lt;/dict&gt;

    &lt;dict&gt;
        &lt;key&gt;Type&lt;/key&gt;
        &lt;string&gt;Text&lt;/string&gt;
        &lt;key&gt;Text&lt;/key&gt;
        &lt;string&gt;You are keen of cheese too, he?&lt;/string&gt;
        &lt;key&gt;Condition&lt;/key&gt;
        &lt;string&gt;FoodLike ==&quot;Tartiflette&quot;&lt;/string&gt;
        &lt;key&gt;TextFontConfiguration&lt;/key&gt;
        &lt;string&gt;Body&lt;/string&gt;
    &lt;/dict&gt;</code></pre>

    <p><u>Note</u>: the key <code>TextFontConfiguration</code> uses a <strong>FontConfiguration</strong> defined in the <strong>FontStyles</strong> section.</p>
    <p>Now, reload the app interface with <strong>⌘R</strong> and… wait a minute! The text is visible although we just added a condition to it! Well, it’s logical actually. The value “Sushis” is <strong>selected by default</strong> in the <code>ListInput</code> component. So the variable <code>FoodLike</code> has the “Sushis” value. We could add <a href="https://documents.getceremony.app/Components.html#validation">validation</a> to it to prevent this behaviour but it is not the purpose of this tutorial. You should rather refer to the one name <a href="">Octory and forms</a>.</p>
    <p>If you select another value than the “Sushis” one, you should see the text disappear, and reappear when you select again “Sushis”.</p>
    <p>It was easy, wasn’t it? And now a little exercise! You did not think I would do all the work myself, did you? 😉 Let’s add the two other <code>Text</code> components. You can set their <code>Text</code> keys to whatever you like. You should add them below the <code>Text</code> component we just added.<br>
    <span class="octo-label-secondary">Small tip: you should copy the <code>Text</code> component we just added and paste it twice.</span></p>
    """

    func testInject1() throws {
        let result =  try FileInjectionService.inject(in: text, using: [PlistInjector(type: .html)] )

        print(result)
    }
}
