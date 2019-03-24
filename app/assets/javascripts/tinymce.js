$(document).on("turbolinks:before-cache",function(){
  console.log('before-cache!')
  tinymce.remove()

})

$(document).on("turbolinks:load",function(){
  console.log('turbolinks:load!')
  tinymce.init({ selector:'#request_content' });
})
