$(document).ready(
  function(){

    var csrf_token = $('meta[name=csrf-token]').attr('content');
    var csrf_param = $('meta[name=csrf-param]').attr('content');
    var params;
    if (csrf_param !== undefined && csrf_token !== undefined) {
        params = csrf_param + "=" + encodeURIComponent(csrf_token);
    }

      $('.redactor').redactor(
        { "imageUpload":"/redactor_rails/pictures?" + params,
          "imageManagerJson":"/redactor_rails/pictures",
          "fileUpload":"/redactor_rails/documents?" + params,
          "fileManagerJson":"/redactor_rails/documents",
          "autoresize":"true",
          "lang":'zh_cn',
          "minHeight": 200,
          "buttonSource": true,
          "plugins": ['table','video','fontcolor','fontsize','fontfamily','fullscreen']
        } 
      );
});
