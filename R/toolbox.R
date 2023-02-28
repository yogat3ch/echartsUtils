#' saveAsImage_filename
#'
#' @description A utils function used in echarts module building chains. The
#' function takes an echarts object in, as well as a name and adds the name to
#' the saveImageAs toolbox feature.
#'
#' @return A modified echarts obj
#'
#' @export

e_saveAsImage_filename = function(e, watermark = FALSE, name = "chart_download.png") {

  if (watermark) {
    onclick <- "function () {
          var ecModel = this.ecModel;
    // from https://echarts.apache.org/examples/en/editor.html?c=line-graphic&edit=1&reset=1
          ecModel.setOption({
            graphic : [
              {
                  type: 'group',
                  rotation: Math.PI / 4,
                  bounding: 'raw',
                  right: '10%',
                  bottom: '10%',
                  z: 100,
                  children: [
                      {
                          type: 'rect',
                          left: 'center',
                          top: 'center',
                          z: 100,
                          shape: {
                              width: 400,
                              height: 50
                          },
                          style: {
                              fill: 'rgba(0,0,0,0.3)'
                          }
                      },
                      {
                          type: 'text',
                          left: 'center',
                          top: 'center',
                          z: 100,
                          style: {
                              fill: '#fff',
                              text: 'ECHARTS LINE CHART',
                              font: 'bold 26px sans-serif'
                          }
                      }
                  ]
              }
          ]
      });
    debugger;
    // from https://github.com/apache/echarts/blob/dfa1f0732972e358a3711c75b5f41db741e986b6/src/component/toolbox/feature/SaveAsImage.ts#L50
        const model = this.model;
        const api = this.api;
        const title = model.get('name') || ecModel.get('title.0.text') || 'echarts';
        const isSvg = api.getZr().painter.getType() === 'svg';
        const type = isSvg ? 'svg' : model.get('type', true) || 'png';
        const url = api.getDataURL({
            type: type,
            backgroundColor: model.get('backgroundColor', true)
                || ecModel.get('backgroundColor') || '#fff',
            connectedBackgroundColor: model.get('connectedBackgroundColor'),
            excludeComponents: model.get('excludeComponents'),
            pixelRatio: model.get('pixelRatio')
        });
        const browser = env.browser;
        // Chrome, Firefox, New Edge
        if (isFunction(MouseEvent) && (browser.newEdge || (!browser.ie && !browser.edge))) {
            const $a = document.createElement('a');
            $a.download = title + '.' + type;
            $a.target = '_blank';
            $a.href = url;
            const evt = new MouseEvent('click', {
                // some micro front-end framework， window maybe is a Proxy
                view: document.defaultView,
                bubbles: true,
                cancelable: false
            });
            $a.dispatchEvent(evt);
        }
    }"
    out <- echarts4r::e_toolbox_feature(e, feature = "myWatermark", show = TRUE, onclick = htmlwidgets::JS(onclick), title = "Dl with Watermark", name = name, icon = 'M4.7,22.9L29.3,45.5L54.7,23.4M4.6,43.6L4.6,58L53.8,58L53.8,43.6M29.2,45.1L29.2,0', type = "png", excludeComponents = 'toolbox')
  } else {
    out <- echarts4r::e_toolbox_feature(e, feature = "saveAsImage", name = name)
  }
  return(out)
}
