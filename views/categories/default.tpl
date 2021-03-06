{% comment %}
	Connect CSS and JavaScript to the header of the document.
{% endcomment %}
{{ 'stylesheet' | jhtml: 'css/style.css' }}

{% comment %}
	Parameters of the category.
{% endcomment %}
{% assign span = tpl_params.cats_span | default_value: 6 %}
{% assign height = tpl_params.cats_height | default_value: 300 %}
{% assign img_height = tpl_params.cats_img_height | default_value: 213 %}
{% case span %}
	{% when 12 %}
		{{ '.list-categories [class*="span"]:nth-child(1n+1) { margin-left: 0; }' | addStyleDeclaration }}
	{% when 6 %}
		{{ '.list-categories [class*="span"]:nth-child(2n+1) { margin-left: 0; }' | addStyleDeclaration }}
	{% when 4 %}
		{{ '.list-categories [class*="span"]:nth-child(3n+1) { margin-left: 0; }' | addStyleDeclaration }}
	{% when 3 %}
		{{ '.list-categories [class*="span"]:nth-child(4n+1) { margin-left: 0; }' | addStyleDeclaration }}
	{% when 2 %}
		{{ '.list-categories [class*="span"]:nth-child(6n+1) { margin-left: 0; }' | addStyleDeclaration }}
{% endcase %}
{% assign cats_desc_length = tpl_params.cats_desc_length | default_value: 0 %}

<!--Header-->
<div class="page-header">
  {% if heading %}
  <h1>{{ heading }}</h1>
  {% else %}
  <h2>{{ title }}</h2>
  {% endif %}
</div>

{% if pretext %}
<!--Pretext-->
<div>
  {{ pretext }}
</div>
{% endif %}

<!--List categories-->
<div class="list-categories">
  <ul class="row-fluid thumbnails">
    {% for category in categories %}
    <li class="span{{ span }}">
      <div class="thumbnail p-10" style="height:{{ height }}px; position: relative;">
        <!--Title category and URL category-->
        <h3>
          <a href="{{ category.url }}">
            {{ category.title }}
          </a>
        </h3>
        <!--Image category-->
        <div>
          <img {{ category.image | img_exists: '321x213' }} style="max-width: 100%; max-height: {{ img_height }}px;" alt="{{ category.image_alt }}" />
        </div>
		{% if category.desc and cats_desc_length %}
        <!--Description category-->
        <div class="m-t-10">
          {{ category.desc | truncateDesc: cats_desc_length }}
        </div>
		{% endif %}
        <div style="position:absolute; bottom:15px; left: 10px; right: 10px;">
          {% if category.children %}
          <!--Subcategories-->
          <div class="dropdown">
            <a href="#" role="button" data-toggle="dropdown" class="btn dropdown-toggle" id="drop{{ category.id }}">
              {{ '_' | jtext: 'JGLOBAL_SUBCATEGORIES' }}
              <span class="caret">&nbsp;</span>
            </a>
            <ul class="dropdown-menu" role="menu" aria-labelledby="drop{{ category.id }}">
              {{ category.children }}
            </ul>
          </div>
          {% else %}
          <!--Products Quantity & Link to the category-->
          <a href="{{ category.url }}" class="btn" title="{{ '_' | jtext: 'COM_JKASSA_QTY' }}: {{ category.num }}">
            <span class="badge">{{ category.num }}</span>
            {{ '_' | jtext: 'COM_JKASSA_READ_MORE_CAT' }}
          </a>
          {% endif %}
        </div>
      </div>
    </li>
    {% endfor %}
  </ul>
</div>

{% if posttext %}
<!--Posttext-->
<div>
  {{ posttext }}
</div>
{% endif %}

{% comment %}
    Connecting comments plugin.
    See: Plugin Manager: Plugins -> jkcomments.
{% endcomment %}
{{ Itemid | jkcomments: title }}