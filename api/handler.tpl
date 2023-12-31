package {{.PkgName}}

import (
        "net/http"

        "github.com/zeromicro/go-zero/rest/httpx"
        "gitlab.playdiss.com/vmee/go-tools/result"
        {{.ImportPackages}}
)

func {{.HandlerName}}(svcCtx *svc.ServiceContext) http.HandlerFunc {
        return func(w http.ResponseWriter, r *http.Request) {
                {{if .HasRequest}}var req types.{{.RequestType}}
                if err := httpx.Parse(r, &req); err != nil {
                        httpx.Error(w, err)
                        return
                }

                {{end}}l := {{.LogicName}}.New{{.LogicType}}(r.Context(), svcCtx)
                {{if .HasResp}}resp, {{end}}err := l.{{.Call}}({{if .HasRequest}}&req{{end}})

                {{if .HasResp}}result.HttpResult(r, w, resp, err){{else}}response.Response(r, w, nil, err){{end}}
                
        }
}
