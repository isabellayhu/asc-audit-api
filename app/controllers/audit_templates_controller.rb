class AuditTemplatesController < ApplicationController
  def create
    @audit_template = current_user.audit_templates.new(audit_template_params)
    if @audit_template.save
      render json: @audit_template
    else
      render json: @audit_template.errors, status: :bad_request
    end
  end
 
  def update
    @audit_template = AuditTemplate.find_by(id: params[:id])
    if @audit_template
      if @audit_template.update(audit_template_params)
        render json: @audit_template
      else
        render json: @audit_template.errors, status: :bad_request
      end
    else
      render json: { error: "Audit template id not found" }, status: :not_found
    end 
  end

  def destroy
    @audit_template = AuditTemplate.find_by(id: params[:id])
    if @audit_template
      @audit_template.destroy!
      head :no_content
    else
      render json: { error: "Audit template id not found" }, status: :not_found
    end 
  end

  private

  def audit_template_params
    params.require(:audit_template).permit(:name)
  end
end
